import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { AngularFireStorage } from '@angular/fire/compat/storage';

@Injectable({
  providedIn: 'root'
})
export class FirebaseImageService {

  constructor(private storage: AngularFireStorage) { }


  uploadImage(file: File, username: string): string {
    if (file.type == "image/jpeg" || file.type == "image/jpg") {
      username += ".jpg";
    }
    const filePath = `image/avatar/${username}`;
    const fileRef = this.storage.ref(filePath);
    const task = this.storage.upload(filePath, file);
    return filePath;
  }

  uploadImageQuiz(file: File, imgName:string): string {
    const fileRef = this.storage.ref(imgName);
    const task = this.storage.upload(imgName, file);
    return imgName;
  }

  getImageUrl(filePath: string) {
    const ref = this.storage.ref(filePath);
    const imageUrl = ref.getDownloadURL();
    return imageUrl;
  }

  deleteImage(imagePath: string) {
    const storageRef = this.storage.ref(imagePath);
    // Xóa ảnh
    storageRef.delete().subscribe(() => {
    }, error => {
      console.error('Error deleting image:', error);
    });
  }
}
