import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, catchError, throwError } from 'rxjs';
import { API_BASE_URL } from '../constant';
import { Router } from '@angular/router';
import { UserUpdate } from '../models/update-user.model';

@Injectable({
  providedIn: 'root'
})
export class AccountService {
  constructor(private http: HttpClient, private router: Router) { }

  login(username: string, password: string): Observable<any> {
    const body = { username, password };
    return this.http.post(`${API_BASE_URL}/SRC001/login`, body);
  }

  signup(fullname: string, email: string, username: string, password: string): Observable<any> {
    const body = { fullname, email, username, password };
    return this.http.post(`${API_BASE_URL}/SRC001/register`, body);
  }

  forgot(email: string): Observable<any> {
    const body = JSON.stringify(email);
    const headers = { 'Content-Type': 'application/json' };
    return this.http.post(`${API_BASE_URL}/SRC001/send-mail-rest-password`, body, { headers: headers });
  }

  getUserId(userId: number): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const options = { headers: headers };
      return this.http.get(`${API_BASE_URL}/SRC001/get-user-public?userId=` + userId, options);
    } else {
      // Trả về một Observable không hợp lệ thay vì null
      return throwError('Token not found.');
    }
  }

  logHistory(quizId?: number): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const options = { headers: headers };
      if (quizId) {
        const body = { quizId };
        return this.http.put(`${API_BASE_URL}/SRC001/upload-history-user`, body, options);
      }
      const body = {};
      return this.http.put(`${API_BASE_URL}/SRC001/upload-history-user`, body, options);
    } else {
      // Trả về một Observable không hợp lệ thay vì null
      return throwError('Token not found.');
    }
  }


  update(user: UserUpdate): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const options = { headers };
      const body = {
        fullname: user.fullname,
        email: user.email,
        images: user.images,
        description: user.description,
        exp: user.exp,
      };
      return this.http.put(`${API_BASE_URL}/SRC001/update-user`, body, options);
    } else {
      // Trả về một Observable không hợp lệ thay vì null
      return throwError('Token not found.');
    }
  }

  changePass(oldpass: string, newpass: string): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const body = { oldpass, newpass };
      return this.http.post(`${API_BASE_URL}/SRC001/change-password`, body, { headers: headers });
    } else {
      // Trả về một Observable không hợp lệ thay vì null
      return throwError('Token not found.');
    }
  }

  addFriend(userId: number, friendId: number): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const body = { userId, friendId };
      return this.http.post(`${API_BASE_URL}/SRC001/send-friend-request`, body, { headers: headers });
    } else {
      // Trả về một Observable không hợp lệ thay vì null
      return throwError('Token not found.');
    }
  }

  declineFriendRequest(userId: number, friendId: number): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const body = { userId, friendId };
      return this.http
      .patch(`${API_BASE_URL}/SRC001/decline-friend`, body, { headers: headers })
      .pipe(
        catchError((error) => {
          console.error('Error:', error);
          return throwError(error);
        })
      );
    } else {
      // Trả về một Observable không hợp lệ thay vì null
      return throwError('Token not found.');
    }
  }

  confirmFriendRequest(userId: number, friendId: number): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const body = { userId, friendId };
      return this.http
      .patch(`${API_BASE_URL}/SRC001/confirm-friends`, body, { headers: headers })
      .pipe(
        catchError((error) => {
          console.error('Error:', error);
          return throwError(error);
        })
      );
    } else {
      // Trả về một Observable không hợp lệ thay vì null
      return throwError('Token not found.');
    }
  }

  getFriendStatus(friendId: number): Observable<any> {

    const headers = this.createHeaders();
    if (headers) {
      return this.http.get<any>(`${API_BASE_URL}/SRC001/friend-status?friendId=${friendId}`, { headers: headers });
    } else {
      // Trả về một Observable không hợp lệ thay vì null
      return throwError('Token not found.');
    }
  }

  private createHeaders() {
    // Tạo HttpHeaders với token
    const token = localStorage.getItem('authToken');
    if (!token) {
      this.router.navigate(['/login']);
      return false;
    }
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    });
    return headers;
  }


  // Lưu token vào localStorage
  saveToken(token: string): void {
    localStorage.setItem('authToken', token);
  }



}
