import { Component, ElementRef, OnInit, QueryList, Renderer2, ViewChildren } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Question } from 'src/app/models/quetion-data.model';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { fadeIn, fadeOutIn } from 'src/assets/animations/animation-quiz';
import { faHashtag, faStar } from '@fortawesome/free-solid-svg-icons';
import { AccountService } from 'src/app/services/account.service';
import { UserUpdate } from 'src/app/models/update-user.model';
import { Quiz } from 'src/app/models/quiz-data.model';
import { Location } from '@angular/common';
import { UserDataService } from 'src/app/services/user-data.service';
import { User } from 'src/app/models/user.model';



@Component({
  selector: 'app-do-quiz-practice',
  templateUrl: './do-quiz-practice.component.html',
  styleUrls: ['./do-quiz-practice.component.scss'],
  animations: [fadeOutIn, fadeIn]
})
export class DoQuizPracticeComponent implements OnInit {
  quizId?: number;
  quiz?: Quiz;
  question?: Question[];
  questionRestore?: Question[];
  currentQuestion = 0;
  selectedOption: number | null = null;
  correctAnswer = 2; // biến để xác định câu tl, 1: đúng - 2: chưa xác định - 0:sai
  numberCorrect = 0; // biến để hiển thị lời khen
  titleQuiz?: string; // biến để hiển thị tên quiz trên header quiz
  finishQuiz: boolean = false; // biến để hiển thị màn finish quiz
  showOptions: boolean = false; // biến mở modal options
  isRandom: boolean = false; // biến random
  showNote: boolean = false; // biến mở modal note
  expUpdate: number = 0; // biến hiển thị exp nhận được
  totalExp: number = 0; // biến tính tổng exp khi làm quiz
  isReceivedExp: boolean = true; // biến kiểm tra có cộng exp hay không
  notPermission: boolean = false; // biến kiểm tra quyền truy cập trang
  user?: User;//biến lưu trữ thông tin user


  //icon
  faHashtag = faHashtag;
  faStar = faStar;

  @ViewChildren('quizletButton') quizletButtons?: QueryList<ElementRef>;

  openOptionsDialog() {
    this.showOptions = true;
  }

  constructor(private renderer: Renderer2, private quizService: QuizDataService, private route: ActivatedRoute, private directRoute: Router,
    private accountService: AccountService, private location: Location, private userDataService: UserDataService) { }

  async ngOnInit(): Promise<void> {
    this.route.params.subscribe(params => {
      this.quizId = params['quizId']; // Lấy giá trị quizId từ đường dẫn
    });
    //code call api lưu lịch sử làm quiz và kiểm tra có nên cộng exp hay không bằng biến isReceivedExp

    //=========================
    if (this.quizId) {
      this.onStartQuiz(this.quizId);
    }

  }

  goBack() {
    this.location.back();
  }

  randomQuestion() {
    if (this.isRandom) {
      if (!this.questionRestore && this.question) {
        this.questionRestore = this.question.slice(); // lưu trữ vị trí các question cũ vào questionRestore
      }
      if (this.question) {
        // Lưu vị trí A
        const questionsBeforeA = this.question.slice(0, this.currentQuestion);

        // Sắp xếp lại các phần tử từ vị trí A đến cuối mảng
        const sortedQuestions = this.question.slice(this.currentQuestion).sort(() => Math.random() - 0.5);

        // Kết hợp với các phần tử từ đầu mảng đến vị trí A
        this.question = [...questionsBeforeA, ...sortedQuestions];
      }

    } else {
      this.question = this.questionRestore;
    }
  }

  showNoteModal() {
    this.showOptions = false;
    this.showNote = true;
  }

  resetQuiz() {
    this.question = this.questionRestore; // khôi phục lại question đã random
    this.isRandom = false;
    this.currentQuestion = 0;
    this.correctAnswer = 2;
    this.numberCorrect = 0;
    this.showNote = false;
  }

  doAgain() {
    this.isReceivedExp = false;
    this.currentQuestion = 0;
    this.correctAnswer = 2;
    this.numberCorrect = 0;
    this.finishQuiz = false;
    //code call api lưu lịch sử làm quiz
  }

  async onStartQuiz(quizId: number) {
    // Gọi service để lấy dữ liệu quiz
    await this.userDataService.userCurr.subscribe(user => {
      if (user.userId && this.quizId) {
        this.user = user;
        this.quizService.getquiz(this.quizId).subscribe(
          (response) => {
            // Xử lý dữ liệu quizData sau khi nhận được từ service
            // lưu vào biến quiz và question trong component
            if (response.result.quizz.quizType == 3) {
              if (response.result.quizz.isFriendCreator) {
                this.quiz = response.result.quizz;
                this.question = response.result.questions;
                this.titleQuiz = response.result.quizz.title;
                this.isReceivedExp = response.result.checkUpEXP;
              } else {
                this.notPermission = true;
              }
            } else {
              this.quiz = response.result.quizz;
              this.question = response.result.questions;
              this.titleQuiz = response.result.quizz.title;
              this.isReceivedExp = response.result.checkUpEXP;
            }
          },
          (error) => {
            console.error('Lỗi khi lấy dữ liệu quiz:', error);
          }
        );

      } else {
        this.userDataService.setUserToken();
      }
    });
  }

  // Kiểm tra xem câu trả lời có đúng không
  checkAnswer(optionIndex: number) {
    if (this.question && optionIndex == this.question[this.currentQuestion].correctAnswer) {
      // Câu trả lời đúng, hiển thị thông báo và chuyển sang câu hỏi tiếp theo
      if (this.isReceivedExp && this.question[this.currentQuestion].difficultyLevel === 1) {
        this.totalExp += 2;
        this.expUpdate = 2;
      }
      if (this.isReceivedExp && this.question[this.currentQuestion].difficultyLevel === 2) {
        this.totalExp += 4;
        this.expUpdate = 4;
      }
      if (this.isReceivedExp && this.question[this.currentQuestion].difficultyLevel === 3) {
        this.totalExp += 6;
        this.expUpdate = 6;
      }
      this.correctAnswer = 1;
      this.numberCorrect += 1;
      if (this.numberCorrect === 4) {//code hiển thị lời khen
        setTimeout(() => {
          this.currentQuestion += 1;
          this.correctAnswer = 2;
          this.numberCorrect = 0;
          if (this.isReceivedExp)
            this.expUpdate = 0;
          if (this.currentQuestion == this.question?.length) {
            this.logAndUpExp();
            this.finishQuiz = true;
          }
        }, 4000);
      } else {
        setTimeout(() => { // code hiển thị đáp án đúng và chuyển câu
          this.currentQuestion += 1;
          this.correctAnswer = 2;
          if (this.isReceivedExp)
            this.expUpdate = 0;
          if (this.currentQuestion == this.question?.length) {
            this.logAndUpExp();
            this.finishQuiz = true;
          }
        }, 2000);
      }

    } else {
      // Câu trả lời sai, đánh dấu lựa chọn sai
      this.correctAnswer = 0;
      this.numberCorrect = 0;
      this.selectedOption = optionIndex;
      setTimeout(() => {
        this.currentQuestion += 1;
        this.correctAnswer = 2;
        if (this.currentQuestion == this.question?.length) {
          this.logAndUpExp();
          this.finishQuiz = true;
        }
      }, 2500);
    }
  }

  private logAndUpExp() {
    if (this.isReceivedExp && this.quizId) { // xử lý log lại lịch sử làm quiz và cộng exp
      this.accountService.logHistory(this.quizId).subscribe(
        (response) => {
          if (response.status && this.totalExp) {  //log lịch sử thành công thì update exp
            const userUpdate: UserUpdate = {
              exp: this.user?.role == 4 ? this.totalExp : (this.totalExp * 2)
            };
            this.accountService.update(userUpdate).subscribe(
              (response) => {

              },
              (error) => {
                console.error('Lỗi khi cộng exp:', error);
              }
            );
          }
        },
        (error) => {
          console.error('Lỗi khi log lịch sử:', error);
        }
      );
    } else {
      this.accountService.logHistory(this.quizId).subscribe(
        (response) => {

        },
        (error) => {
          console.error('Lỗi khi log lịch sử:', error);
        }
      );
    }
  }

  handleKeyPress(event: KeyboardEvent) {
    // Lấy số từ sự kiện phím được nhấn
    if (this.correctAnswer == 2) {
      const keyNumber = parseInt(event.key);
      if (this.question) {
        const sizeQues = this.question[this.currentQuestion].optionsSRC002?.length;
        // Kiểm tra xem số có nằm trong phạm vi số nút bạn đang quản lý
        if (!isNaN(keyNumber) && sizeQues && keyNumber >= 1 && keyNumber <= sizeQues) {
          // Xử lý việc chọn nút
          this.checkAnswer(keyNumber);
        }
      }
    }
  }

  redirectBack() {
    this.directRoute.navigate(['/quiz-detail/' + this.quizId]);

  }


}
