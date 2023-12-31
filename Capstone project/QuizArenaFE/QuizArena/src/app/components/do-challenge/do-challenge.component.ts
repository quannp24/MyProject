import { Component, ElementRef, OnInit, QueryList, Renderer2, ViewChild, ViewChildren } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Question } from 'src/app/models/quetion-data.model';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { fadeIn, fadeOutIn } from 'src/assets/animations/animation-quiz';
import { faHashtag, faStar, faTimes } from '@fortawesome/free-solid-svg-icons';
import { AccountService } from 'src/app/services/account.service';
import { ChallengeService } from 'src/app/services/challenge.service';
import { SignalrService } from 'src/app/services/signalr.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { User } from 'src/app/models/user.model';

@Component({
  selector: 'app-do-challenge',
  templateUrl: './do-challenge.component.html',
  styleUrls: ['./do-challenge.component.scss'],
  animations: [fadeOutIn, fadeIn]
})
export class DoChallengeComponent {
  quizId?: number;
  question?: Question[];
  currentQuestion = 0;
  selectedOption: number | null = null;
  correctAnswer = 2; // biến để xác định câu tl, 1: đúng - 2: chưa xác định - 0:sai
  titleQuiz?: string; // biến để hiển thị tên quiz trên header quiz
  finishQuiz: boolean = false; // biến để hiển thị màn finish quiz
  showModalExit: boolean = false; // biến mở modal exit
  scoreUpdate: number = 0; // biến hiển thị score nhận được
  totalScore: number = 0; // biến tính tổng score khi làm quiz
  timeDisplay: number = 15;
  @ViewChild('ss') ssElement?: ElementRef;
  @ViewChild('sec_dot') dotElement?: ElementRef;
  examId?: string;// biến lưu examId
  intervalId: any; // Biến để theo dõi ID của interval
  timeOut: boolean = false; // biến xem thời gian hết chưa
  percentProgress: number = 0 // biến % tiến trình làm quiz
  @ViewChildren('quizletButton') quizletButtons?: QueryList<ElementRef>;
  questionResult: { index?: number, questionId?: number, result?: boolean, score?: number }[] = []; // biến theo dõi kết quả làm challenge của user
  numberCorrect: number = 0; // biến đếm số câu đúng
  percentCorrect: number = 0;//biến % câu đúng
  userInfor?: User; //biến lưu thông tin user
  expiredChallenge: boolean = false;// biến xem chall hết thoi gian ch
  private timeoutId: any;

  //icon
  faHashtag = faHashtag;
  faStar = faStar;
  faTimes = faTimes;


  constructor(private renderer: Renderer2, private userDataService: UserDataService, private quizService: QuizDataService, private route: ActivatedRoute, private directRoute: Router,
    private accountService: AccountService, private challService: ChallengeService, private signalRService: SignalrService) {
    this.route.params.subscribe(params => {
      this.quizId = params['quizId']; // Lấy giá trị quizId từ đường dẫn
      this.examId = params['examId'];
    });

    this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
        this.userInfor = user;
        if (this.quizId) {
          this.onStartQuiz(this.quizId);
          this.SetupSignalR();
        }
      } else {
        this.userDataService.setUserToken();
      }
    });
  }


  async ngOnInit(): Promise<void> {

    this.signalRService.isConnectedSubject.subscribe((isConnected) => {
      if (isConnected) {
        this.signalRService.ListenTimeOut((data: any) => {  //nghe sự kiện challenge hết giờ
          console.log('test timeout')

          if (data.status) {
            this.finishChallenge();
          } else {
            console.log('Lỗi timeout challenge: ' + data.message);
          }
        });
      }
    });

  }

  /*
  * Hàm kết nối signalR
  */
  private async SetupSignalR(): Promise<void> {
    this.signalRService.isConnectedSubject.subscribe((isConnected) => {
      if (isConnected && this.signalRService.isConnected()) {
        if (this.examId) {
          this.signalRService.joinChallenge(this.examId);
        }
      } else {
        if (this.userInfor)
          this.signalRService.startConnection(this.userInfor.userId); //mở kết nối signalR
      }
    });
  }

  /*
  * Thêm câu tl vào danh sách questionResult
  */
  private async addQuestionResult(result: boolean, score: number) {
    if (this.question) {
      const newQuestionResult = {
        index: this.currentQuestion,
        questionId: this.question[this.currentQuestion].questionId,
        result: result,
        score: score,
      };
      this.questionResult.push(newQuestionResult);
    }

  }

  /*
  * Hàm tính score dựa theo level quiz và tgian trả lời
  */
  calculateScore(answerCorrect: boolean, level: number | undefined, secondsTaken: number): number {
    if (!answerCorrect) {
      return 0; // Trả về 0 nếu câu trả lời là sai
    }
    const maxSeconds = level === 1 ? 5 : (level === 2 ? 7 : 10);
    // Đảm bảo thời gian trả lời nằm trong giới hạn từ 1 đến maxSeconds
    const bonusScore = Math.min(Math.max(1, secondsTaken), level === 1 ? 10 : (level === 2 ? 12 : 15));
    const totalScore = maxSeconds + bonusScore - 1;
    // console.log('time answer: '+secondsTaken + '  | level: '+level+'  | score ques: '+maxSeconds+'  | score bonus: '+bonusScore + ' | total score: '+totalScore);
    return totalScore;
  }

  /*
  * Hàm tính phần trăm tiến trình làm challenge
  */
  private caculatePercent() {
    if (this.question?.length) {
      const percent = ((this.currentQuestion + 1) / this.question.length) * 100;
      this.percentProgress = percent;
    }
  }

  /*
  * Hàm update score cho user
  */
  private saveScore() {
    if (this.examId)
      this.challService.updateStatusAndScore(this.examId, this.totalScore).subscribe(
        (response) => {
          if (response.status) {
            this.updateStatusUserAndChallenge();
          }
        },
        (error) => {
          console.error('Lỗi khi update score:', error);
        }
      );
  }

  /*
  * Hàm update status user thi xong và challenge
  */
  private updateStatusUserAndChallenge() {
    if (this.examId)
      this.challService.updateFinishChallenge(this.examId).subscribe(
        (response) => {
          if (response.status) {

          } else {
            console.log('Lỗi khi update finish challenge:', response.message);
          }
        },
        (error) => {
          console.error('Lỗi khi update finish challenge:', error);
        }
      );
  }

  /*
  * Hàm xử lý đếm ngược thời gian
  */
  private countDownTime(second: number) {
    let distance = (second + 1) * 1000;
    this.intervalId = setInterval(() => {
      distance -= 1000;
      if (distance >= 0) {
        let s = Math.floor((distance % (1000 * 60)) / 1000);
        this.timeDisplay = s;
        if (this.ssElement)
          this.ssElement.nativeElement.style.strokeDashoffset = 440 - (440 * s) / second;
        if (this.dotElement)
          this.dotElement.nativeElement.style.transform = `rotateZ(${s * (360 / second)}deg)`;
      } else {
        clearInterval(this.intervalId); // Dừng interval khi hết thời gian
        this.timeOut = true;
        this.caculatePercent();
        this.timeoutId = setTimeout(() => { // code hiển thị hết giờ và chuyển câu
          this.addQuestionResult(false, 0);
          if (this.currentQuestion + 1 == this.question?.length) {
            this.calculatePercentCorrect();
            this.saveScore();
            this.finishQuiz = true;
            return;
          }
          if (this.question && this.question[this.currentQuestion + 1].difficultyLevel == 1) {
            this.countDownTime(10);
            this.timeOut = false;
            this.correctAnswer = 2;
            this.currentQuestion += 1;
          } else {
            this.countDownTime(15);
            this.timeOut = false;
            this.correctAnswer = 2;
            this.currentQuestion += 1;
          }
        }, 2500);
      }
    }, 1000);
  }

  /*
  * Hàm hiển thị modal confirm exit
  */
  confirmExit() {
    this.showModalExit = true;
  }


  /*
  * Hàm tính % câu tl đúng
  */
  private calculatePercentCorrect() {
    if (this.questionResult.length > 0) {
      const trueCount = this.questionResult.filter(ques => ques.result).length;
      const totalCount = this.questionResult.length;

      this.percentCorrect = (trueCount / totalCount) * 100;
    }
  }



  /*
  * Hàm lấy dữ liệu quiz
  */
  async onStartQuiz(quizId: number) {
    if (this.examId) {
      this.challService.getInforChallengeDetail(this.examId).subscribe(
        (response) => {
          if (response.status && this.quizId) {
            if (response.result.examInfo.status == 5) {
              this.expiredChallenge = true;
            } else {
              // Gọi service để lấy dữ liệu quiz
              this.quizService.getquiz(this.quizId).subscribe(
                (response) => {
                  this.titleQuiz = response.result.quizz.title;
                  if (response.result.questions[0])
                    this.countDownTime(response.result.questions[0].difficultyLevel == 1 ? 10 : (response.result.questions[0].difficultyLevel == 2 ? 12 : 15));
                  this.question = response.result.questions;
                },
                (error) => {
                  console.error('Lỗi khi lấy dữ liệu quiz:', error);
                }
              );
            }
          }
        },
        (error) => {
          console.error('Lỗi khi lấy dữ liệu challenge:', error);
        }
      );
    }

  }

  private async finishChallenge(): Promise<void> {
    clearTimeout(this.timeoutId);
    clearInterval(this.intervalId);
    this.calculatePercentCorrect();
    this.saveScore();
    this.finishQuiz = true;
  }

  /*
  * Hàm kiểm tra và xử lý khi chọn đáp án
  */
  checkAnswer(optionIndex: number) {
    this.caculatePercent();
    if (this.question && optionIndex == this.question[this.currentQuestion].correctAnswer && this.question[this.currentQuestion].difficultyLevel) {
      // Câu trả lời đúng, hiển thị thông báo và chuyển sang câu hỏi tiếp theo
      const score = this.calculateScore(true, this.question[this.currentQuestion].difficultyLevel, this.timeDisplay);
      this.addQuestionResult(true, score);
      this.totalScore += score;
      this.scoreUpdate = score;
      clearInterval(this.intervalId);
      this.correctAnswer = 1;
      this.numberCorrect += 1;
      this.timeoutId = setTimeout(() => { // code hiển thị đáp án đúng và chuyển câu
        if (this.currentQuestion + 1 == this.question?.length) {
          this.calculatePercentCorrect();
          this.saveScore();
          this.finishQuiz = true;
          return;
        }
        if (this.question && this.question[this.currentQuestion + 1].difficultyLevel == 1) {
          this.countDownTime(10);
          this.scoreUpdate = 0;
          this.correctAnswer = 2;
          this.currentQuestion += 1;
        } else {
          this.countDownTime(15);
          this.scoreUpdate = 0;
          this.correctAnswer = 2;
          this.currentQuestion += 1;
        }
      }, 2000);
    } else {
      // Câu trả lời sai, đánh dấu lựa chọn sai
      clearInterval(this.intervalId);
      this.addQuestionResult(false, 0);
      this.correctAnswer = 0;
      this.selectedOption = optionIndex;
      this.timeoutId = setTimeout(() => {
        if (this.currentQuestion + 1 == this.question?.length) {
          this.saveScore();
          this.calculatePercentCorrect();
          this.finishQuiz = true;
          return;
        }
        if (this.question && this.question[this.currentQuestion + 1].difficultyLevel == 1) {
          this.countDownTime(10);
          this.scoreUpdate = 0;
          this.currentQuestion += 1;
          this.correctAnswer = 2;
        } else {
          this.countDownTime(15);
          this.scoreUpdate = 0;
          this.currentQuestion += 1;
          this.correctAnswer = 2;
        }
      }, 2500);
    }
  }


  /*
  * Hàm xử lý sự kiện nhấn phím chọn đáp án
  */
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
}
