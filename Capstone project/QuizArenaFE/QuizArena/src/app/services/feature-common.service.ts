import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable, throwError } from 'rxjs';
import { API_BASE_URL } from '../constant';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class FeatureCommonService {
  private searchResultsSubject = new BehaviorSubject<any[]>([]);
  public searchResults$ = this.searchResultsSubject.asObservable();

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

  searchInfo(): Observable<any> {
    return this.http.get(`${API_BASE_URL}/SRC001/search-homepage`);
  }

  getNotify(): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      return this.http.get(`${API_BASE_URL}/SRC001/Get-Notification-User`, { headers: headers });
    } else {
      // Trả về một Observable không hợp lệ thay vì null
      return throwError('Token not found.');
    }
  }

  resetSession(): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const options = { headers };
      return this.http.get(`${API_BASE_URL}/SRC001/reset-session`, options);
    } else {
      return throwError('Token not found.');
    }
  }

  payment(fullname: string, amount: number): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const options = { headers };
      const body = { fullname, amount };
      return this.http.post(`${API_BASE_URL}/Payment/Request-Payment`, body, options);
    } else {
      return throwError('Token not found.');
    }
  }

  addPaymentInfo(paymentMethod: string, amount: number): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const options = { headers };
      const body = { paymentMethod, amount };
      return this.http.post(`${API_BASE_URL}/controller/InsertPayment`, body, options);
    } else {
      return throwError('Token not found.');
    }
  }

  updateSearchResults(results: any[]) {
    this.searchResultsSubject.next(results);
  }

}
