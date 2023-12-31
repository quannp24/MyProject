import { Component, ElementRef, HostListener, OnDestroy, OnInit, QueryList, Renderer2, ViewChildren } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Question } from 'src/app/models/quetion-data.model';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { fadeIn, fadeOutIn } from 'src/assets/animations/animation-quiz';
import { faHashtag, faStar } from '@fortawesome/free-solid-svg-icons';
import { AccountService } from 'src/app/services/account.service';
import { UserUpdate } from 'src/app/models/update-user.model';
import { UserDataService } from 'src/app/services/user-data.service';
import { SignalrService } from 'src/app/services/signalr.service';
import { User } from 'src/app/models/user.model';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { Quiz } from 'src/app/models/quiz-data.model';

@Component({
  selector: 'app-do-quiz-friends',
  templateUrl: './do-quiz-friends.component.html',
  styleUrls: ['./do-quiz-friends.component.scss'],
  animations: [fadeOutIn, fadeIn]
})
export class DoQuizFriendsComponent implements OnInit, OnDestroy {
  quizId?: number;
  roomId?: string;
  user?: User;
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
  roleUser: number = 0; // biến xác định role của user có được làm hay chỉ xem, 0:khách | 1:chủ phòng |2:support
  userInRoom: User[] = []; // biến lưu danh sách người trong phòng
  notPermission: boolean = false; // biến kiểm tra user join room
  isChatting: boolean = false; // biến kiểm tra đang chat hay không để ngăn sự kiện nhấn phím chọn đáp án
  isHelperMode: boolean = false;//biến trạng thái helper hay không
  becomeHelper: boolean = false; // biến hiển thị thông báo thành helper
  helperOut: boolean = false;// biến hiển thị khi helper out khỏi room
  lostHelper: boolean = false;// biến hiển thị khi mất helper
  quiz?: Quiz; // biến thông tin quiz

  //icon
  faHashtag = faHashtag;
  faStar = faStar;

  @ViewChildren('quizletButton') quizletButtons?: QueryList<ElementRef>;

  constructor(private renderer: Renderer2, private quizService: QuizDataService, private route: ActivatedRoute, private directRoute: Router,
    private accountService: AccountService, private userDataService: UserDataService, private signalRService: SignalrService, private fireBase: FirebaseImageService) {

    this.route.params.subscribe(params => {
      this.quizId = params['quizId']; // Lấy giá trị quizId từ đường dẫn
      this.roomId = params['roomId']; // Lấy giá trị roomId từ đường dẫn
    });
    if (this.roomId && this.quizId)
      this.quizService.checkPermissionJoinRoom(this.roomId, this.quizId).subscribe( //kiểm tra quyền vào room, được vào thì add vào db
        (response) => {
          if (response.status) {
            if (!response.result) {
              this.notPermission = true;
              return;
            }
          }
          this.SetupPage();//setup infor page
        },
        (error) => {
          console.error('Lỗi khi check permission:', error);
        }
      );
  }

  async ngOnInit(): Promise<void> {
    this.signalRService.isConnectedSubject.subscribe((isConnected) => {
      if (isConnected) { //để code lắng nghe sự kiện
        this.signalRService.ReceivedAnswerSelected((data: any) => {  //nghe sự kiện chủ phòng chọn đáp án
          if (data.status) {
            if (data.result.currentQuestion == this.currentQuestion) {
              this.checkAnswer(data.result.answer);
            } else {
              this.currentQuestion = data.result.currentQuestion + 1;
              this.totalExp = data.result.totalExp;
              this.numberCorrect = data.result.numberCorrect;
            }
          }
        });
        this.signalRService.ReceivedEventDoAgain((data: any) => {  //nghe sự kiện chủ phòng chọn làm lại quiz
          if (data.status) {
            this.UserDoAgain();
          }
        });

        this.signalRService.ReceivedChangeHelper((data: any) => {  //nghe sự kiện thay đổi helper
          if (data.status) {
            this.ChangeHelper(data.result);
          } else {
            console.log('Lỗi nhận sự kiện thay đổi helper: ' + data.message);
          }
        });

        this.signalRService.ReceivedRemoveHelper((data: any) => {  //nghe sự kiện bỏ chế độ helper
          if (data.status) {
            this.removeHelperInUserInRoom(data.result);
          } else {
            console.log('Lỗi nhận sự kiện bạn bè vào phòng khác: ' + data.message);
          }
        });
      }
    });
  }

  /*
   * Hàm xử lý sự kiện xóa helper
   */
  private removeHelperInUserInRoom(userIdHelper: number) {
    if (userIdHelper == this.user?.userId) {
      this.roleUser = 0;
      this.lostHelper = true;
      setTimeout(() => {
        this.lostHelper = false;
      }, 4000);
    } else {
      // Tìm và set lại role cho user có role = 2 thành 0
      const userWithRole2 = this.userInRoom.find(user => user.role === 2);
      if (userWithRole2) {
        userWithRole2.role = 0;
      }
    }
  }

  /*
   * Hàm xử lý sự kiện thay đổi helper
   */
  private async ChangeHelper(userIdHelper: number): Promise<void> {
    if (userIdHelper == this.user?.userId) {
      this.roleUser = 2;
      this.becomeHelper = true;
      setTimeout(() => {
        this.becomeHelper = false;
      }, 4000);
    } else {
      // Tìm và set lại role cho user có role = 2 thành 0
      const userWithRole2 = this.userInRoom.find(user => user.role === 2);
      if (userWithRole2) {
        userWithRole2.role = 0;
      }

      const userToUpdate = this.userInRoom.find(user => user.userId === userIdHelper);
      if (userToUpdate) {
        userToUpdate.role = 2;
      } else {
        console.error(`User with userId ${userIdHelper} not found.`);
      }

    }
  }

  /*
  * Hàm theo dõi sự thay đổi helperOut từ footer-do-quiz
  */
  handleChangeUserRoom(userRoom: User[]) {
    this.userInRoom = userRoom;
  }

  /*
   * Hàm theo dõi sự thay đổi helperOut từ footer-do-quiz
   */
  handleChangeHelperOut(status: boolean) {
    this.helperOut = status;
  }

  /*
   * Hàm theo dõi sự thay đổi isHelperMode từ footer-do-quiz
   */
  handleChangeHelperMode(status: boolean) {
    this.isHelperMode = status;
  }


  /*
   * Hàm lấy các thông tin cho trang
   */
  private async SetupPage(): Promise<void> {
    await this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
        this.user = user;
        this.signalRService.isConnectedSubject.subscribe((isConnected) => {
          if (isConnected) {
            if (this.roomId) {
              this.signalRService.joinRoom(this.roomId);
            }
          } else {
            this.signalRService.startConnection(user.userId); //mở kết nối signalR
          }
        });
        if (this.quizId) {
          this.onStartQuiz(this.quizId);
        }
      } else {
        this.userDataService.setUserToken();
      }
    });
  }


  /*
  * Hàm lấy thông tin quiz
  */
  private async onStartQuiz(quizId: number) {
    // Gọi service để lấy dữ liệu quiz
    if (this.quizId)
      await this.quizService.getquiz(this.quizId).subscribe(
        (response) => {
          this.question = response.result.questions;
          this.quiz = response.result.quizz;
          this.titleQuiz = response.result.quizz.title;
          this.isReceivedExp = response.result.checkUpEXP;
          if (this.roomId) {
            this.quizService.getInforRoomQuiz(this.roomId).subscribe(
              (res) => {
                if (res.status) {
                  // this.userInRoom = res.result.usersInRoom;
                  this.getImageUserFirebase(res.result.usersInRoom);
                  this.currentQuestion = res.result.userDoQuiz.currentQuestion;
                  this.totalExp = res.result.userDoQuiz.totalExp;
                  this.roleUser = res.result.userDoQuiz.role;
                }
              },
              (error) => {
                console.error('Lỗi khi lấy dữ liệu quiz:', error);
              }
            );
          }
        },
        (error) => {
          console.error('Lỗi khi lấy dữ liệu quiz:', error);
        }
      );
  }

  /*
  * Hàm lấy ảnh của user trên firebase
  */
  private async getImageUserFirebase(userRoom: User[]) {
    let count = 0;
    if (userRoom) {
      await userRoom.forEach((slide, index) => {
        if (slide.images) {
          this.fireBase.getImageUrl(slide.images).subscribe(
            (url) => {
              if (userRoom) {
                userRoom[index].images = url;
                count++;

                if (count === userRoom.length) {
                  this.userInRoom = userRoom;
                }
              }
            },
            (error) => {
              console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
            }
          );
        } else {
          count++;
          if (count === userRoom.length) {
            this.userInRoom = userRoom;
          }
        }
      });
    }
  }

  /*
  * Hàm xử lý chức năng random question
  */
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

  /*
 * Hàm hiển thị modal note khi reset quiz
 */
  showNoteModal() {
    this.showOptions = false;
    this.showNote = true;
  }


  goBack() {
    this.directRoute.navigate(['/quiz-detail/' + this.quizId]);
  }

  /*
  * Hàm mở modal options
  */
  openOptionsDialog() {
    this.showOptions = true;
  }

  /*
  * Hàm xử lý chức năng reset quiz
  */
  resetQuiz() {
    this.question = this.questionRestore; // khôi phục lại question đã random
    this.isRandom = false;
    this.currentQuestion = 0;
    this.correctAnswer = 2;
    this.numberCorrect = 0;
    this.showNote = false;
  }

  /*
  * Hàm xử lý gửi sự kiện làm lại quiz cho room
  */
  SendDoAgain() {
    if (this.roleUser == 1 && this.roomId) {
      this.signalRService.DoAgainQuiz(this.roomId);
    }
  }

  /*
  * Hàm xử lý chức năng làm lại quiz
  */
  UserDoAgain() {
    this.isReceivedExp = false;
    this.currentQuestion = 0;
    this.correctAnswer = 2;
    this.numberCorrect = 0;
    this.finishQuiz = false;
  }

  /*
* Hàm gửi sự kiện chọn đáp án
*/
  sendAnswerToRoom(optionIndex: number) {
    if (this.roomId && this.roleUser != 0) { //gửi sự kiện chọn đáp án
      this.signalRService.SendAnswerSelected(optionIndex, this.roomId, this.totalExp, this.currentQuestion, this.numberCorrect);
    }
  }


  /*
  * Hàm xử lý khi nhấn chọn đáp án
  */
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


  /*
  * Hàm xử lý lưu lịch sử làm quiz và cộng exp
  */
  private logAndUpExp() {
    if (this.isReceivedExp && this.quizId) { // xử lý log lại lịch sử làm quiz và cộng exp
      if (this.roleUser == 1) {
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
      }
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


  /*
  * Hàm xử lý nhấn phím chọn đáp án
  */
  handleKeyPress(event: KeyboardEvent) {
    // Lấy số từ sự kiện phím được nhấn
    if (!this.isChatting && this.correctAnswer == 2) {
      const keyNumber = parseInt(event.key);
      if (this.question) {
        const sizeQues = this.question[this.currentQuestion].optionsSRC002?.length;
        // Kiểm tra xem số có nằm trong phạm vi số nút bạn đang quản lý
        if (!isNaN(keyNumber) && sizeQues && keyNumber >= 1 && keyNumber <= sizeQues) {
          // Xử lý việc chọn nút
          if (this.roomId && this.roleUser == 1) { //gửi sự kiện chọn đáp án
            this.signalRService.SendAnswerSelected(keyNumber, this.roomId, this.totalExp, this.currentQuestion, this.numberCorrect);
          }
        }
      }
    }
  }

  /*
  * Hàm quay lại trang quiz-detail
  */
  redirectBack() {
    this.directRoute.navigate(['/quiz-detail/' + this.quizId]);

  }


  @HostListener('window:beforeunload', ['$event'])
  unloadNotification($event: any): void {
    // Thực hiện hành động bạn muốn khi người dùng thoát khỏi trang
    if (this.roomId)
      this.signalRService.OutRoomQuiz(this.roomId);
  }

  ngOnDestroy(): void {
    // Gỡ bỏ sự kiện khi component bị hủy bỏ
    if (this.roomId)
      this.signalRService.OutRoomQuiz(this.roomId);
    window.removeEventListener('beforeunload', this.unloadNotification);
  }

  /*
  * Hàm chặn keyup khi đang chat
  */
  handleChangeChatting(status: boolean) {
    this.isChatting = status;
  }

}
