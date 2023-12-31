import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { API_BASE_URL } from '../constant';
import { Observable, catchError, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class DashboardService {

  constructor(private http: HttpClient) { }

  private createHeaders() {
    const token = localStorage.getItem('authToken');
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    });
    return headers;
  }

  getDashboardStatistics(): Observable<any> {
    const headers = this.createHeaders();
    return this.http.get(`${API_BASE_URL}/controller/dashboard-statistics`, { headers });
  }

  getListQuizAndSearch(searchTerm: string | null = null, difficultyLevel: number | null = null, status: number | null = null, page: number = 1, pageSize: number = 10): Observable<any> {
    const headers = this.createHeaders();

    // Tạo HttpParams và thêm các tham số vào nếu chúng không null hoặc undefined
    let params = new HttpParams()
      .set('searchTerm', searchTerm || '')
      .set('status', status?.toString() || '')
      .set('page', page.toString())
      .set('pageSize', pageSize.toString());

    // Thêm difficultyLevel vào nếu giá trị khác null
    if (difficultyLevel !== null && difficultyLevel !== undefined) {
      params = params.set('difficultyLevel', difficultyLevel.toString());
    }

    return this.http.get(`${API_BASE_URL}/controller/quiz-manager`, { headers, params });
  }


  getAllUsesrList(searchTerm: string | null, page: number = 1, pageSize: number = 10): Observable<any> {
    const headers = this.createHeaders();
    const params = new HttpParams()
      .set('searchTerm', searchTerm || '')
      .set('page', page.toString())
      .set('pageSize', pageSize.toString());

    return this.http.get<any>(`${API_BASE_URL}/controller/user-manager`, { headers, params });
  }

  getListUserUsuallyActive(): Observable<any> {
    const headers = this.createHeaders();
    return this.http.get(`${API_BASE_URL}/controller/user-manager/recent-activity`, { headers });
  }

  changeQuizStatus(quizId: number, newStatus: number): Observable<any> {
    const headers = this.createHeaders();
    const body = {
      quizId: quizId,
      status: newStatus,
    };
    return this.http.put<any>(`${API_BASE_URL}/SRC002/change-quiz-status`, body, { headers });
  }

  updateUser(userId: number, exp?: number, roleId?: number): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const body = {
        ExpToAdd: exp,
        NewRoleId: roleId,
      };
      return this.http
        .put(`${API_BASE_URL}/controller/update-user/${userId}`, body, { headers: headers })
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

  sendActiveUserEmail(): Observable<any> {
    const headers = this.createHeaders();
    return this.http.post<any>(`${API_BASE_URL}/controller/update-user`, { headers: headers }).pipe(
      catchError((error: any) => {
        console.error('Error sending activity reminder email:', error);
        throw error;
      })
    );
  }

  updateQuizStatus(quizId: number, status: number, comment?: string): Observable<any> {
    const headers = this.createHeaders();
    const body = {
      quizId: quizId,
      status: status,
      comment: comment
    };

    return this.http.put<any>(`${API_BASE_URL}/SRC002/change-quiz-status`, body, { headers: headers }).pipe(
      catchError((error: any) => {
        console.error('Error changing quiz status:', error);
        throw error;
      })
    );
  }
  // mail custom
  sendCustomEmail(userEmail: string, subject: string, content: string): Observable<any> {
    const headers = this.createHeaders();
    const request = {
      userEmail: userEmail,
      subject: subject,
      content: content,
    };

    return this.http.post<any>(`${API_BASE_URL}/controller/send-custom-email`, request, { headers });
  }

  sendActivityReminderEmail(): Observable<any> {
    const headers = this.createHeaders();
    return this.http.post<any>(`${API_BASE_URL}/controller/send-activity-reminder-email`, {}, { headers: headers });
  }

  sendInActivityReminderEmail(): Observable<any> {
    const headers = this.createHeaders();
    return this.http.post<any>(`${API_BASE_URL}/controller/send-inactive-user-invitation-email`, {}, { headers: headers });
  }

  getUsersRecentActivity(searchTerm: string | null, page: number = 1, pageSize: number = 10): Observable<any> {
    const headers = this.createHeaders();
    const params = new HttpParams()
      .set('searchTerm', searchTerm || '')
      .set('page', page.toString())
      .set('pageSize', pageSize.toString());

    return this.http.get<any>(`${API_BASE_URL}/controller/user-manager/recent-activity`, { headers, params });
  }

  getUsersInfrequentActivity(searchTerm: string | null, page: number = 1, pageSize: number = 10): Observable<any> {
    const headers = this.createHeaders();
    const params = new HttpParams()
      .set('searchTerm', searchTerm || '')
      .set('page', page.toString())
      .set('pageSize', pageSize.toString());

    return this.http.get<any>(`${API_BASE_URL}/controller/user-manager/infrequent-activity`, { headers, params });
  }

  getUnapprovedQuizzes(): Observable<any> {
    return this.http.get<any>(`${API_BASE_URL}/SRC002/unapproved-quizzes`);
  }

  getApprovedQuizzes(): Observable<any> {
    return this.http.get<any>(`${API_BASE_URL}/SRC002/approved-quizzes`);
  }

  getListExam(): Observable<any> {
    return this.http.get<any>(`${API_BASE_URL}/SRC002/list-exam`);
  }

  deleteExam(examId: string): Observable<any> {
    const headers = this.createHeaders();
    return this.http.delete(`${API_BASE_URL}/SRC002/delete-exam/${examId}`, { headers });
  }

  changeExamStatus(examId: string, newStatus: number): Observable<any> {
    const headers = this.createHeaders();
    return this.http.put(`${API_BASE_URL}/SRC002/change-exam-status/${examId}/${newStatus}`, null, { headers });
  }


  getFriends(userId: number, searchTerm?: string, page: number = 1, pageSize: number = 1000): Observable<any> {
    const headers = this.createHeaders();
    let params = new HttpParams()
      .set('searchTerm', searchTerm || '')
      .set('page', page.toString())
      .set('pageSize', pageSize.toString());

    return this.http.get(`${API_BASE_URL}/SRC001/list-friends/${userId}`, { headers, params });
  }

  getUserHistory(searchTerm?: string, page: number = 1, pageSize: number = 1000): Observable<any> {
    const headers = this.createHeaders();
    let params = new HttpParams()
      .set('searchTerm', searchTerm || '')
      .set('page', page.toString())
      .set('pageSize', pageSize.toString());

    return this.http.get(`${API_BASE_URL}/controller/user-history`, { headers, params });
  }

  getPaymentsWithUsername(searchTerm?: string, page: number = 1, pageSize: number = 1000): Observable<any> {
    const headers = this.createHeaders();
    let params = new HttpParams()
      .set('searchTerm', searchTerm || '')
      .set('page', page.toString())
      .set('pageSize', pageSize.toString());

    return this.http.get(`${API_BASE_URL}/controller/List-payments`, { headers, params });
  }

}
