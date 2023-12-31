import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, throwError } from 'rxjs';
import { API_BASE_URL } from '../constant';

@Injectable({
  providedIn: 'root'
})
export class ChallengeService {

  constructor(private http: HttpClient, private router: Router) { }

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

  getInforChallengePage(): Observable<any> {
    const token = localStorage.getItem('authToken');
    if (token) {
      const headers = new HttpHeaders({
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`,
      });
      const options = { headers: headers };

      return this.http.get(`${API_BASE_URL}/SRC002/Get-Exam-Info`, options);
    } else {
      return this.http.get(`${API_BASE_URL}/SRC002/Get-Exam-Info`);
    }

  }

  getInforLobbyChallenge(examId: string): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const options = { headers: headers };
      return this.http.get(`${API_BASE_URL}/SRC002/get-infor-lobby?examid=` + examId, options);
    } else {
      // Trả về một Observable không hợp lệ thay vì null
      return throwError('Token not found.');
    }
  }

  getInforChallengeDetail(examId: string): Observable<any> {
    const token = localStorage.getItem('authToken');
    if (token) {
      const headers = new HttpHeaders({
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`,
      });
      const options = { headers: headers };
      return this.http.get(`${API_BASE_URL}/SRC002/get-infor-challenge-detail?examid=` + examId, options);
    } else {
      return this.http.get(`${API_BASE_URL}/SRC002/get-infor-challenge-detail?examid=` + examId);
    }
  }

  addUserExam(examId: string): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const options = { headers };
      const body = { examId };
      return this.http.post(`${API_BASE_URL}/SRC002/Insert-Exam-User`, body, options);
    } else {
      // Trả về một Observable không hợp lệ thay vì null
      return throwError('Token not found.');
    }
  }

  updateStatusAndScore(examId: string, score?: number): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const options = { headers };
      const body = { examId, score };
      return this.http.post(`${API_BASE_URL}/SRC002/update-status-score-user-exam`, body, options);
    } else {
      // Trả về một Observable không hợp lệ thay vì null
      return throwError('Token not found.');
    }
  }


  updateFinishChallenge(examId: string): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const options = { headers };
      return this.http.put(`${API_BASE_URL}/SRC002/update-finish-challenge?examId=${examId}`, undefined, options);
    } else {
      // Trả về một Observable không hợp lệ thay vì null
      return throwError('Token not found.');
    }
  }
}
