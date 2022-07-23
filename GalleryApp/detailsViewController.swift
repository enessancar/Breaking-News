
import UIKit

class detailsViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var detailTitle: UITextField!
    @IBOutlet weak var dShortDesc: UITextField!
    @IBOutlet weak var selectImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectImageButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }

    @IBAction func saveImageButton(_ sender: Any) {
        
        let title = detailTitle.text ?? ""
        let ShortDesc = dShortDesc.text ?? ""
        
        if let imagedData = selectImage.image?.jpegData(compressionQuality: 1) {
            DatabaseHelper.shareInstance.save(title: title, shortDescription: ShortDesc, image: imagedData)
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let userPickedImage = info[.editedImage] as? UIImage else{return}
        selectImage.image = userPickedImage
        picker.dismiss(animated: true, completion: nil)
    }
}
