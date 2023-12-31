import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { User } from '../models/user.model';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { API_BASE_URL } from '../constant';
import { FirebaseImageService } from './firebase-image.service';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class UserDataService {

  private loginFormSubject = new BehaviorSubject<boolean>(false);
  loginForm$ = this.loginFormSubject.asObservable();

  private loggedUser = new BehaviorSubject<User>(<User>{});
  userCurr = this.loggedUser.asObservable();

  constructor(private http: HttpClient, private fireService: FirebaseImageService,public router: Router) { }


  setloginForm(value: boolean) {
    this.loginFormSubject.next(value);
  }

  async setUserToken() {
    // Lấy token từ Local Storage
    const token = localStorage.getItem('authToken');

    // Kiểm tra xem token có tồn tại hay không
    if (token) {
      // Tạo HttpHeaders với token
      const headers = new HttpHeaders({
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`,
      });

      // Tạo các tùy chọn cho yêu cầu HTTP
      const options = { headers: headers };

      // Thực hiện cuộc gọi API GET với header chứa token
      await this.http.get(`${API_BASE_URL}/SRC001/get-user-info`, options).subscribe(
        (response: any) => {
          const user = response.result;
          if (user.images && user.images != "") {
            this.fireService.getImageUrl(user.images).subscribe(
              (url) => {
                user.images = url;
                this.loggedUser.next(user);
              },
              (error) => {
                console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
                this.loggedUser.next(user);
              }
            );
          }else{
            this.loggedUser.next(user);
          }

        },
        (error) => { // token hết hạn
          localStorage.removeItem('authToken');
          this.router.navigate(['/login']);
        }
      );
    } else {
      // Xử lý trường hợp không có token trong Local Storage
      console.log('Token not found in Local Storage.');
      this.router.navigate(['/login']);

    }
  }


}
