import { AfterViewInit, Component, ElementRef, HostListener, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { faSmile, faPaperPlane, faUserPlus, faMessage, faVolumeHigh, faVolumeXmark } from '@fortawesome/free-solid-svg-icons';
import { switchMap } from 'rxjs';
import { ChatData } from 'src/app/models/chat.model';
import { User } from 'src/app/models/user.model';
import { ChallengeService } from 'src/app/services/challenge.service';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { SignalrService } from 'src/app/services/signalr.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { slideInFromBottomMess } from 'src/assets/animations/animation-quiz';


@Component({
  selector: 'app-lobby-challenge',
  templateUrl: './lobby-challenge.component.html',
  styleUrls: ['./lobby-challenge.component.scss'],
  animations: [slideInFromBottomMess]
})
export class LobbyChallengeComponent implements OnInit, OnDestroy {
  isChatBoxVisible: boolean = false; // biến mở chat box
  isShowSticker = false; // biến show box gif
  chatList: ChatData[] = []; //biến hiển thị chat
  @ViewChild('audioPlayer') audioPlayer?: ElementRef<HTMLAudioElement>; // biến sound lobby
  isAudioPlaying: boolean = false; // biến trạng thái cho sound đang chạy hay không
  @ViewChild('gifGrid') gifGrid?: ElementRef;
  userInfor?: User; //biến lưu thông tin user
  examId?: string // biến lưu mã challenge
  notPermission: boolean = false; // biến kiểm tra quyền truy cập trang
  messError: string = ''; // biến kiểm tra quyền truy cập trang
  usersChallenge: User[] = [];  // danh sách người trong challenge
  inforChall: { examName?: string, numberQuesion?: number, timeLimit?: number, examType?: number, image?: string, date?: Date, quizId?: number } = {};
  countdown?: number; // biến đếm ngược challenge tới
  displayTime?: string; // biến hiển thị thời gian đếm ngược
  showBtnJoin: boolean = false; // biến hiển thị nút vào thi
  @ViewChild('scrollMe') private myScrollContainer?: ElementRef; // biến scroll đến new msg
  gifSrc: string = 'assets/images/sticker-duck/';




  //icon
  faSmile = faSmile;
  faPaperPlane = faPaperPlane;
  faUserPlus = faUserPlus;
  faMessage = faMessage;
  faVolumeHigh = faVolumeHigh;
  faVolumeXmark = faVolumeXmark;



  constructor(private userDataService: UserDataService, private signalRService: SignalrService,
    private fireBase: FirebaseImageService, private directRoute: Router, private route: ActivatedRoute, private challengeService: ChallengeService) {

    this.route.params.subscribe(params => {
      this.examId = params['examId']; // Lấy giá trị examId từ đường dẫn
    });

    this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
        this.userInfor = user;
        if (this.examId)
          this.challengeService.getInforLobbyChallenge(this.examId).subscribe(
            (response) => {
              if (response.status) {
                if (!response.result.permissionJoin) {//kiểm tra quyền vào challenge
                  this.messError = 'Wrong! You can not permission access this page.';
                  this.notPermission = true;
                  return;
                } else {
                  this.SetupSignalR();
                  this.setupInforChallenge(response.result.inforExam[0]);
                  this.setupUserInChallenge(response.result.listUserExam);
                }
              }
            },
            (error) => {
              console.error('Lỗi khi lấy infor lobby:', error);
            }
          );
      } else {
        this.userDataService.setUserToken();
      }
    });

  }

  async ngOnInit(): Promise<void> {
    this.signalRService.isConnectedSubject.subscribe((isConnected) => {
      if (isConnected) {

        this.signalRService.ListenUserJoinLobby((data: any) => {  //nghe sự kiện có người vào lobby
          if (data.status) { // thêm người vào userChall
            this.addUserJoinLobby(data.result);
          } else {
            console.log('Lỗi nhận sự kiện người mới vào lobby: ' + data.message);
          }
        });

        this.signalRService.ListenUserOutLobby((data: any) => {  //nghe sự kiện có người thoát lobby
          if (data.status) { // xóa người vào userChall
            this.removeUsersInLobby(data.result);
          } else {
            console.log('Lỗi nhận sự kiện có người thoát lobby: ' + data.message);
          }
        });

        this.signalRService.ReceivedMessageLobby((data: any) => {  //nghe sự kiện user gửi tin nhắn
          if (data.status) {
            if (data.result.from != this.userInfor?.userId)
              this.addNewChat(data.result.from, data.result.message, false);
          } else {
            console.log('Lỗi nhận tin nhắn: ' + data.message);
          }
        });

        this.signalRService.ReceivedStickerLobby((data: any) => {  //nghe sự kiện user gửi sticker
          if (data.status) {
            if (data.result.from != this.userInfor?.userId) {
              this.addNewChat(data.result.from, data.result.message, true);
            }
          } else {
            console.log('Lỗi nhận sticker: ' + data.message);
          }
        });

      }
    });
  }


  /*
  * Hàm xử lý remove user trong danh sách usersRoom
  */
  private removeUsersInLobby(userId?: number) {
    if (userId && this.usersChallenge) {
      const userIndex = this.usersChallenge.findIndex((u) => u.userId === userId);
      if (userIndex !== -1) {
        this.usersChallenge.splice(userIndex, 1);
      }
    }
  }

  /*
   * Hàm thêm user vào danh sách usersChallenge(người trong challenge)
   */
  private async addUserJoinLobby(user?: User): Promise<void> {
    if (user && user.userId != this.userInfor?.userId) {
      // Kiểm tra xem người dùng đã tồn tại trong mảng chưa
      const userExists = this.usersChallenge.some(u => u.userId === user.userId);
      // Lấy ảnh đại diện của người vừa vào
      if (!userExists) {
        if (this.usersChallenge) {
          if (user.images) {
            this.fireBase.getImageUrl(user.images).subscribe(
              (url) => {
                if (url && this.usersChallenge) {
                  user.images = url;
                  this.usersChallenge = [...this.usersChallenge, user];
                }
              },
              (error) => {
                console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
              }
            );
          } else {
            this.usersChallenge = [...this.usersChallenge, user];
          }
        }

      }
    }
  }

  /*
   * Hàm gửi sự kiện out lobby khi thoát khỏi trang
   */
  @HostListener('window:beforeunload', ['$event'])
  unloadNotification($event: any): void {
    // Thực hiện hành động bạn muốn khi người dùng thoát khỏi trang
    if (this.examId)
      this.signalRService.OutLobbyChallenge(this.examId);
  }

  /*
   * Hàm gửi sự kiện out lobby khi thoát khỏi component
   */
  ngOnDestroy(): void {
    // Gỡ bỏ sự kiện khi component bị hủy bỏ
    if (this.examId)
      this.signalRService.OutLobbyChallenge(this.examId);
    window.removeEventListener('beforeunload', this.unloadNotification);
  }

  /*
  * Hàm setup các thông tin challenge
  */
  private async setupInforChallenge(chall: any) {
    if (chall) {
      if (chall.image) {
        try {
          const url = await this.fireBase.getImageUrl(chall.image).toPromise();
          if (url) {
            chall.image = url;
          } else {
            chall.image = '';
          }
          this.inforChall = chall;
          this.setCountDown();
          setInterval(() => this.setCountDown(), 1000);

        } catch (error) {
          console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
        }
      } else {
        chall.image = '';
        this.inforChall = chall;
        this.setCountDown();
        setInterval(() => this.setCountDown(), 1000);

      }
    }
  }

  /*
   * Hàm xử lý status và tham gia challenge
   */
  doChallenge() {
    if (this.examId)
      this.challengeService.updateStatusAndScore(this.examId).subscribe(
        (response) => {
          if (response.status) {
            if (response.result && this.inforChall.quizId) { // update status thành 1 thành công
              if (this.examId)
                this.directRoute.navigate(['/do-challenge/' + this.inforChall.quizId + '/' + this.examId]);
            } else {
              this.messError = 'Something wrong, please try again!';
              this.notPermission = true;
            }
          }
        },
        (error) => {
          this.messError = 'Something wrong, please try again!';
          this.notPermission = true;
          console.error('Lỗi khi lấy infor lobby:', error);
        }
      );
  }


  /*
   * Hàm xử lý đếm ngược thời gian bắt đầu challenge
   */
  private async setCountDown() {
    if (this.inforChall.date) {
      const now = new Date().getTime();
      const targetDate = new Date(this.inforChall.date).getTime(); // Ngày cố định

      this.countdown = Math.max(0, Math.floor((targetDate - now) / 1000));

      const minutes = Math.floor(this.countdown / 60);
      const seconds = this.countdown % 60;

      if (this.countdown == 0) {
        this.showBtnJoin = true;
      }

      this.displayTime = `${this.padZero(minutes)} minutes ${this.padZero(seconds)} seconds`;
    }
  }

  private padZero(value: number): string {
    return value < 10 ? `0${value}` : `${value}`;
  }

  /*
   * Hàm xử lý lấy và thêm message, gọi tới khi nhắn enter hoặc send ở chat
   */
  sendMessage(): void {
    const messageInput = document.getElementsByName('message')[0] as HTMLInputElement;
    const message = messageInput.value.trim();

    if (message !== '' && this.userInfor) {
      this.addNewChat(this.userInfor.userId, message, false);
      if (this.examId)
        this.signalRService.SendMessagesLobby(message, this.examId);
      messageInput.value = ''; // Clear the input field after sending the message
    }
  }

  /*
* Hàm xử lý nhấn vào sticker
*/
  addSelectedGif(gifSrcd: string) {
    this.gifSrc = 'assets/images/sticker-duck/';
    this.gifSrc += gifSrcd;
    if (this.examId && this.userInfor) {
      this.signalRService.SendStickerLobby(this.gifSrc, this.examId);
      this.addNewChat(this.userInfor?.userId, this.gifSrc, true); // thêm chat mới
    }

  }


  /*
   * Hàm xử lý thêm đoạn chat mới
   */
  addNewChat(userId: number, message: string, typeMess: boolean): void {
    if (this.userInfor && userId !== this.userInfor?.userId) {
      const user = this.usersChallenge.find(u => u.userId === userId);
      if (user) {
        const isFirstInSequence = this.isFirstInSequence(user.userId);
        const newChat: ChatData = { from: user, message, time: new Date(), isFirstInSequence, isSticker: typeMess };
        this.chatList.push(newChat);
        this.scrollToBottom();
      } else {
        console.error('User not found with userId:', userId);
      }
    } else {
      if (this.userInfor) {
        const isFirstInSequence = this.isFirstInSequence(this.userInfor.userId);
        const newChat: ChatData = { from: this.userInfor, message, time: new Date(), isFirstInSequence, isSticker: typeMess };
        this.chatList.push(newChat);
        this.scrollToBottom();
      }
    }
  }

  /*
   * Hàm check đoạn chat đầu của user
   */
  private isFirstInSequence(userId: number): boolean {
    if (this.chatList.length === 0) {
      return true; // Nếu danh sách trống, đây là tin nhắn đầu tiên
    }
    // Lấy tin nhắn cuối cùng trong danh sách
    const lastChat = this.chatList[this.chatList.length - 1];
    // Kiểm tra xem userId của tin nhắn mới có giống với userId của tin nhắn cuối cùng không
    return lastChat.from.userId !== userId;
  }

  /*
  * Hàm scroll auto đến new msg
  */
  scrollToBottom(): void {
    try {
      if (this.myScrollContainer) {
        setTimeout(() => {
          if (this.myScrollContainer)
            this.myScrollContainer.nativeElement.scrollTop = this.myScrollContainer.nativeElement.scrollHeight;
        }, 0);
      }
    } catch (err) { }
  }

  /*
  * Hàm setup các thông tin cho user trong challenge
  */
  private async setupUserInChallenge(usersChall: User[]) {
    if (usersChall) {
      const promises = usersChall.map(async (slide) => {
        if (slide.images) {
          try {
            const url = await this.fireBase.getImageUrl(slide.images).toPromise();
            slide.images = url;
          } catch (error) {
            console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
          }
        } else {
          slide.images = '';
        }
        return slide;
      });

      try {
        const list = await Promise.all(promises);
        this.usersChallenge = list;
      } catch (error) {
        console.error('Lỗi khi xử lý setup user challenge:', error);
      }
    }
  }


  /*
   * Hàm kết nối signalR
   */
  private async SetupSignalR(): Promise<void> {
    this.signalRService.isConnectedSubject.subscribe((isConnected) => {
      if (isConnected && this.signalRService.isConnected()) {
        if (this.examId) { //
          this.signalRService.joinLobbyChallenge(this.examId);
        }
      } else {
        if (this.userInfor)
          this.signalRService.startConnection(this.userInfor.userId); //mở kết nối signalR
      }
    });
  }

  /*
  * Hàm xử lý bật tắt sound
  */
  toggleAudio() {
    if (this.isAudioPlaying && this.audioPlayer) {
      this.audioPlayer?.nativeElement.pause();
    } else {
      if (this.audioPlayer) {
        this.audioPlayer.nativeElement.volume = 0.1;
        this.audioPlayer?.nativeElement.play();
      }
    }
    this.isAudioPlaying = !this.isAudioPlaying;
  }



  /*
 * Hàm mở box gif
 */
  toggleGifGrid() {
    this.isShowSticker = !this.isShowSticker;
  }


  /*
  * Hàm xử lý sự kiện đóng box gif
  */
  @HostListener('document:click', ['$event'])
  handleClickOutside(event: Event) {

    if (this.gifGrid && !this.gifGrid.nativeElement.contains(event.target)) {
      this.isShowSticker = false;
    }
  }


}
