import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { API_BASE_URL } from '../constant';
import { Observable, catchError, throwError } from 'rxjs';
import { ExamData } from '../models/exam-data.model';

@Injectable({
  providedIn: 'root'
})
export class ExamService {

  constructor(private http: HttpClient) { }

  private createHeaders() {
    const token = localStorage.getItem('authToken');
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    });
    return headers;
  }

  getQuizzesByTypeAndStatus(): Observable<any> {
    const headers = this.createHeaders();
    return this.http.get(`${API_BASE_URL}/SRC002/GetQuizzesByTypeAndStatus`, { headers });
  }

  getExamById(examId: string): Observable<any> {
    const headers = this.createHeaders();
    return this.http.get(`${API_BASE_URL}/SRC002/GetExamById?examId=${examId}`, { headers });
  }

  addExam(data: ExamData): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      return this.http.post(`${API_BASE_URL}/SRC002/CreateExam`, data, { headers: headers });
    } else {
      return throwError('Token not found.');
    }
  }

  updateExam(data: ExamData): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      return this.http.post(`${API_BASE_URL}/SRC002/EditExam`, data, { headers: headers });
    } else {
      return throwError('Token not found.');
    }
  }


}