import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { API_BASE_URL } from '../constant';
import { Observable, catchError, throwError } from 'rxjs';
import { InsertQuizReq } from '../models/insert-quiz-req.model';
import { QuizSetData } from '../models/quiz-set-data.model';

@Injectable({
  providedIn: 'root'
})
export class QuizDataService {

  constructor(private http: HttpClient) { }

  private createHeaders() {
    // Tạo HttpHeaders với token
    const token = localStorage.getItem('authToken');
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    });
    return headers;
  }

  getquiz(quizId: number): Observable<any> {
    const headers = this.createHeaders();
    return this.http.get(`${API_BASE_URL}/SRC002/GetQuiz?quizId=${quizId}`, { headers });
  }

  getUserDoQuizToday(quizId: number): Observable<any> {
    return this.http.get(`${API_BASE_URL}/SRC002/user-do-today?quizId=${quizId}`);
  }

  getQuizPopularRecent(): Observable<any> {
    const headers = this.createHeaders();
    return this.http.get(`${API_BASE_URL}/SRC002/GetQuizRecentPopular`, { headers });
  }

  deleteQuiz(quizId: number, quiz_type: number): Observable<any> {
    const headers = this.createHeaders();
    return this.http.delete(`${API_BASE_URL}/SRC002/delete-quiz?quizId=${quizId}&quiz_type=${quiz_type}`, { headers });
  }

  createRoomQuiz(quizId: number): Observable<any> {
    const body = { quizId };
    const headers = this.createHeaders();
    if (headers) {
      const options = { headers: headers };
      return this.http.post(`${API_BASE_URL}/SRC002/create-room-quiz-friends`, body, options);

    } else {
      // Trả về một Observable không hợp lệ thay vì null
      return throwError('Token not found.');
    }
  }

  getInforRoomQuiz(roomId: string): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const options = { headers: headers };
      return this.http.get(`${API_BASE_URL}/SRC002/get-infor-do-quiz?roomId=` + roomId, options);
    } else {
      // Trả về một Observable không hợp lệ thay vì null
      return throwError('Token not found.');
    }
  }

  getRandomQuestion(categoryId: number, numLv1: number, numLv2: number, numLv3: number): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const options = { headers: headers };
      return this.http.get(`${API_BASE_URL}/SRC002/GetQuestionsRandom?Lvl1=` + numLv1 + `&Lvl2=` + numLv2 + `&Lvl3=` + numLv3 + `&category=` + categoryId, options);
    } else {
      return throwError('Token not found.');
    }
  }

  getFriendsListRoom(roomId: string): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const options = { headers: headers };
      return this.http.get(`${API_BASE_URL}/SRC001/get-list-friend?roomId=${roomId}`, options);
    } else {
      // Trả về một Observable không hợp lệ thay vì null
      return throwError('Token not found.');
    }
  }

  checkPermissionJoinRoom(roomId: string, quizId: number): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const body = { roomId, quizId };
      const options = { headers: headers };
      return this.http.post(`${API_BASE_URL}/SRC002/Friend-Join-Room-Quiz`, body, options);
    } else {
      // Trả về một Observable không hợp lệ thay vì null
      return throwError('Token not found.');
    }
  }

  getCategory(): Observable<any> {
    return this.http.get(`${API_BASE_URL}/controller/get-category`);
  }

  addQuiz(data: QuizSetData): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      return this.http.post(`${API_BASE_URL}/SRC002/AddQuiz`, data, { headers: headers });
    } else {
      return throwError('Token not found.');
    }
  }

  updateQuiz(data: QuizSetData): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      return this.http.post(`${API_BASE_URL}/SRC002/Update-Quiz`, data, { headers: headers });
    } else {
      return throwError('Token not found.');
    }
  }

  updateQuizPrivate(data: QuizSetData): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      return this.http.post(`${API_BASE_URL}/SRC002/Update-Quiz-Private`, data, { headers: headers });
    } else {
      return throwError('Token not found.');
    }
  }

  updateStatusQuiz(quizId: number, status: number): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const body = { quizId, status };
      return this.http.put(`${API_BASE_URL}/SRC002/change-quiz-status`, body, { headers: headers });
    } else {
      return throwError('Token not found.');
    }
  }

  getListQuizActive(): Observable<any> {
    return this.http.get(`${API_BASE_URL}/SRC002/GetActiveQuizzes`);
  }

  getListQuizByCategoryId(categoryId: number): Observable<any> {
    return this.http.get(`${API_BASE_URL}/SRC002/quizzes-by-category/${categoryId}`);
  }

  getListQuizPrivate(userId: number): Observable<any> {
    return this.http.get(`${API_BASE_URL}/SRC002/get-list-quiz-user?userId=${userId}`);
  }

  getListQuiForStaff(): Observable<any> {
    const headers = this.createHeaders();
    return this.http.get(`${API_BASE_URL}/SRC002/quizzes-by-staff-and-status`, { headers: headers });
  }

  getAchievementsUser(userId: number): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      return this.http.get(`${API_BASE_URL}/SRC002/get-achievements-user?userId=${userId}`, { headers: headers });
    } else {
      return throwError('Token not found.');
    }
  }

  addQuestion(categoryId: number, listquestions: any): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const body = { categoryId, listquestions };
      return this.http.post(`${API_BASE_URL}/SRC002/AddQuestions`, body, { headers: headers });
    } else {
      return throwError('Token not found.');
    }
  }

  editQuestion(categoryId: number, listquestions: any): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      const body = { categoryId, listquestions };
      console.log("body", body)
      return this.http.put(`${API_BASE_URL}/SRC002/EditQuestions`, body, { headers: headers });
    } else {
      return throwError('Token not found.');
    }
  }
  getQuestionsByCategory(categoryId: number, status: number, userId?: number): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      if (userId) {
        return this.http.get(`${API_BASE_URL}/SRC002/GetQuestionsByCategory?categoryId=${categoryId}&status=${status}&userId=${userId}`, { headers: headers });
      } else {
        return this.http.get(`${API_BASE_URL}/SRC002/GetQuestionsByCategory?categoryId=${categoryId}&status=${status}`, { headers: headers });
      }
    } else {
      return throwError('Token not found.');
    }
  }
  getCategoryByStatus(status: number, userId?: number): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      if (userId) {
        return this.http.get(`${API_BASE_URL}/controller/categories-by-status?status=${status}&userId=${userId}`, { headers: headers });
      } else {
        return this.http.get(`${API_BASE_URL}/controller/categories-by-status?status=${status}`, { headers: headers });
      }
    } else {
      return throwError('Token not found.');
    }
  }

  deleteQuestion(questionId: number): Observable<any> {
    const headers = this.createHeaders();
    if (headers) {
      return this.http.post(`${API_BASE_URL}/controller/DeleteQuestion?questionId=${questionId}`, null, { headers: headers });
    } else {
      return throwError('Token not found.');
    }
  }

  addCategory(categoryName: string): Observable<any> {
    const headers = this.createHeaders();
    const body = { categoryName };
    if (headers) {
      return this.http.post(`${API_BASE_URL}/controller/AddCategory`, body, { headers: headers });
    } else {
      return throwError('Token not found.');
    }
  }

  updateCategory(categoryId: number, categoryName: string): Observable<any> {
    const headers = this.createHeaders();
    const body = { categoryId, categoryName };
    if (headers) {
      return this.http.post(`${API_BASE_URL}/controller/UpdateCategory`, body, { headers: headers });
    } else {
      return throwError('Token not found.');
    }
  }



}
