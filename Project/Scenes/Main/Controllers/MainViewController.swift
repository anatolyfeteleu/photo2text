//
//  MainViewController.swift
//  authPet
//
//  Created by Анатолий Фетелеу on 16.03.2023.
//

import UIKit
import Vision
import Combine

class MainViewController: UIViewController {
    var coordinator: Coordinator?
    
    private var cancellables: Set<AnyCancellable> = []
    
    var mainView = MainView()
    
    var cameraViewController: UIImagePickerController!
    
    var viewModel: MainViewModel!
    
    // MARK: - life cycle
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        configureViews()
        configureBindings()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: life cycle -
        
    private func setup() {}
    
    private func configureViews() {
        configureCameraViewController()
        configureCameraButtonView()
        configureTableView()
    }
    
    private func configureBindings() {}
    
}

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Public methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage ?? nil else { return }
        recognizeText(image: image)
        picker.dismiss(animated: true)
    }
    
    // MARK: - Private methods
    
    private func recognizeText(image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        
        // Handler
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        // Request
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let observations =
                    request.results as? [VNRecognizedTextObservation] else { return }
            let text = observations.compactMap {
                $0.topCandidates(1).first?.string
            }.joined(separator: ", ")
            
            self?.viewModel.scanTexts.append(text)
            self?.mainView.tableView.reloadData()
        }
        request.recognitionLanguages = ["Russian", "English"]
        
        // Process request
        do {
            try handler.perform([request])
        } catch {
            debugPrint("Error occured: \(error)")
        }
    }
    
    // MARK: - Button actions
    
    @objc private func cameraButtonTapped() {
        coordinator?.present(viewController: cameraViewController, animated: true, completion: nil)
    }
    
    // MARK: - Private methods
    
    private func configureCameraButtonView() {
        mainView.cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
    }
    
    private func configureCameraViewController() {
        cameraViewController = {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.cameraDevice = .rear
            imagePicker.cameraFlashMode = .off
            imagePicker.delegate = self
            return imagePicker
        }()
    }
    
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    struct Cells {
        static var note: String = "note"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.scanTexts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.note, for: indexPath) as! MainViewCell
        let text = viewModel.scanTexts[indexPath.row]
        cell.setLabelViewText(text!)
        return cell
    }
    
    // MARK: - Private methods
    
    private func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.tableView.register(MainViewCell.self, forCellReuseIdentifier: MainViewController.Cells.note)
    }
    
    
}
