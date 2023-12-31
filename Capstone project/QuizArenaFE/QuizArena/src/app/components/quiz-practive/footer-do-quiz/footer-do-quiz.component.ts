import { AfterViewChecked, Component, ElementRef, EventEmitter, HostListener, Input, OnInit, Output, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { faSmile, faPaperPlane, faUserPlus, faMessage } from '@fortawesome/free-solid-svg-icons';
import { ChatData } from 'src/app/models/chat.model';
import { User } from 'src/app/models/user.model';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { SignalrService } from 'src/app/services/signalr.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { fadeInOut, fadeInOverflow, slideInFromBottomMess } from 'src/assets/animations/animation-quiz';


@Component({
  selector: 'app-footer-do-quiz',
  templateUrl: './footer-do-quiz.component.html',
  styleUrls: ['./footer-do-quiz.component.scss'],
  animations: [fadeInOut, fadeInOverflow, slideInFromBottomMess]
})
export class FooterDoQuizComponent implements OnInit {
  @ViewChild('gifGrid') gifGrid?: ElementRef;
  gifSrc: string = 'assets/images/sticker-duck/';
  selectedGifs: string[] = []; //biến hiển thị gif
  @Input() usersRoom: User[] = []; //biến danh sách người trong room
  @Input() roleUser?: number; //biến xác định role của user có được làm hay chỉ xem, 0:khách | 1:chủ phòng |2:support
  @Input() roomId?: string; //biến roomId lấy từ do-quiz-friends
  @Input() quizId?: number; //biến quizId lấy từ do-quiz-friends
  @Input() userBoss?: User; //biến user lấy từ do-quiz-friends
  showModal: boolean = false; // biến hiển thị modal user in room
  showModalInvite: boolean = false; // biến hiển thị modal friends
  friendsOnl?: User[]; // biến lưu danh sách bạn bè online
  friendsOff?: User[]; // biến lưu danh sách bạn bè offline
  isLoadedOnl: boolean = false; // biến skeleton online
  isLoadedOff: boolean = false; // biến skeleton offline
  isShowSticker = false; // biến show box gif
  chatList: ChatData[] = []; //biến hiển thị chat
  @ViewChild('scrollMe') private myScrollContainer?: ElementRef; // biến scroll đến new msg
  isChatBoxVisible: boolean = false; // biến mở chat box
  @Output() changeChatting: EventEmitter<boolean> = new EventEmitter<boolean>(); // biến thay đổi trạng thái isChatting ở do-quiz-friends
  @Output() changeHelperMode: EventEmitter<boolean> = new EventEmitter<boolean>(); // biến thay đổi isHelperMode ở do-quiz-friends
  @Output() changeHelperOut: EventEmitter<boolean> = new EventEmitter<boolean>(); // biến thay đổi helperOut ở do-quiz-friends
  @Output() changeUserRoom: EventEmitter<User[]> = new EventEmitter<User[]>(); // biến thay đổi userinRoom ở do-quiz-friends
  modalBossOut: boolean = false; // biến hiển thị modal khi boss out


  //icon
  faSmile = faSmile;
  faPaperPlane = faPaperPlane;
  faUserPlus = faUserPlus;
  faMessage = faMessage;

  constructor(private userDataService: UserDataService, private signalRService: SignalrService, private quizService: QuizDataService,
    private fireBase: FirebaseImageService, private directRoute: Router) {
  }

  async ngOnInit(): Promise<void> {
    this.signalRService.isConnectedSubject.subscribe((isConnected) => {
      if (isConnected) {
        this.signalRService.ListenFriendOff((data: any) => {  //nghe sự kiện bạn bè off
          this.updateFriendListOff(data);
        });
        this.signalRService.ListenFriendOnl((data: any) => {  //nghe sự kiện bạn bè onl
          this.updateFriendListOnl(data);
        });
        this.signalRService.ListenUserOutRoom((data: any) => {  //nghe user out room
          if (data.status) {
            if (data.result.roleUser == 1) { // chủ phòng out room
              this.removeUsersInRoom(data.result.userId);
              this.modalBossOut = true;
              setTimeout(() => {
                this.directRoute.navigate(['/quiz-detail/' + this.quizId]);
              }, 5000);
            } else { // user out room
              this.changeBtnFriendOnl(data.result.userId);
              this.removeUsersInRoom(data.result.userId);
            }
          }
        });
        this.signalRService.UserJoinRoom((data: any) => {  //nghe sự kiện user vào phòng
          if (data.status) {
            // this.changeInRoomFriendOnl(data.result);
            this.addUserJoinRoom(data.result);
          }
        });

        this.signalRService.ReceivedMessage((data: any) => {  //nghe sự kiện user gửi tin nhắn
          if (data.status) {
            if (data.result.from != this.userBoss?.userId)
              this.addNewChat(data.result.from, data.result.message, false);
          } else {
            console.log('Lỗi nhận tin nhắn: ' + data.message);
          }
        });

        this.signalRService.ReceivedSticker((data: any) => {  //nghe sự kiện user gửi sticker
          if (data.status) {
            if (data.result.from != this.userBoss?.userId) {
              this.addNewChat(data.result.from, data.result.message, true);
              this.addNewSticker(data.result.message);
            }
          } else {
            console.log('Lỗi nhận sticker: ' + data.message);
          }
        });

        this.signalRService.ListenFriendJoinMyRoom((data: any) => {  //nghe sự kiện bạn bè vào phòng mình
          if (data.status) {
            this.changeInRoomFriendOnl(data.result);
            // this.addUserJoinRoom(data.result);
          } else {
            console.log('Lỗi nhận sự kiện bạn bè vào phòng mình: ' + data.message);
          }
        });

        this.signalRService.ListenFriendJoinOrtherRoom((data: any) => {  //nghe sự kiện bạn bè vào phòng người khác
          if (data.status) {
            this.changeBusyFriendOnl(data.result); //đổi thành busy
          } else {
            console.log('Lỗi nhận sự kiện bạn bè vào phòng khác: ' + data.message);
          }
        });


      }
    });
  }


  addHelper(userId: number) {
    if (this.roleUser == 1 && this.roomId) {
      this.changeHelperMode.emit(true);
      this.signalRService.AddHelper(this.roomId, userId);
    }
  }

  removeHelper(userId: number) {
    if (this.roleUser == 1 && this.roomId) {
      this.changeHelperMode.emit(false);
      this.signalRService.RemoveHelper(this.roomId, userId);
    }
  }

  /*
  * Hàm thêm sticker vào selectedGifs để hiển thị
  */
  private addNewSticker(gifSrc: string) {
    this.selectedGifs.push(gifSrc);
    setTimeout(() => {
      this.selectedGifs.splice(0, 1);
    }, 7000);
  }


  /*
   * Hàm thay đổi biến isChatting ở do-quiz-friend
   */
  onInput() {
    this.changeChatting.emit(true);
  }

  /*
   * Hàm thay đổi biến isChatting ở do-quiz-friend
   */
  changeStatusChatting() {
    this.changeChatting.emit(false);
  }


  /*
   * Hàm xử lý thêm đoạn chat mới
   */
  addNewChat(userId: number, message: string, typeMess: boolean): void {
    if (this.usersRoom && userId !== this.userBoss?.userId) {
      const user = this.usersRoom.find(u => u.userId === userId);
      if (user) {
        const isFirstInSequence = this.isFirstInSequence(user.userId);
        const newChat: ChatData = { from: user, message, time: new Date(), isFirstInSequence, isSticker: typeMess };
        this.chatList.push(newChat);
        this.scrollToBottom();

      } else {
        console.error('User not found with userId:', userId);
      }
    } else {
      if (this.userBoss) {
        const isFirstInSequence = this.isFirstInSequence(this.userBoss.userId);
        const newChat: ChatData = { from: this.userBoss, message, time: new Date(), isFirstInSequence, isSticker: typeMess };
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
   * Hàm xử lý lấy và thêm message, gọi tới khi nhắn enter hoặc send ở chat
   */
  sendMessage(): void {
    const messageInput = document.getElementsByName('message')[0] as HTMLInputElement;
    const message = messageInput.value.trim();

    if (message !== '' && this.userBoss) {
      this.addNewChat(this.userBoss.userId, message, false);
      if (this.roomId)
        this.signalRService.SendMessages(message, this.roomId);
      messageInput.value = ''; // Clear the input field after sending the message
    }
  }

  /*
   * Hàm thêm user vào danh sách userInRoom(người trong room)
   */
  private async addUserJoinRoom(user?: User): Promise<void> {
    if (user && user.userId != this.userBoss?.userId) {
      // Kiểm tra xem người dùng đã tồn tại trong mảng chưa
      const userExists = this.usersRoom.some(u => u.userId === user.userId);

      // Lấy ảnh đại diện của người vừa vào
      if (!userExists) {
        if (this.usersRoom) {
          if (user.images) {
            this.fireBase.getImageUrl(user.images).subscribe(
              (url) => {
                if (url && this.usersRoom) {
                  user.images = url;
                  this.usersRoom = [...this.usersRoom, user];
                  this.changeUserRoom.emit(this.usersRoom);
                }
              },
              (error) => {
                console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
              }
            );
          } else {
            this.usersRoom = [...this.usersRoom, user];
            this.changeUserRoom.emit(this.usersRoom);
          }
        }
      }
    }
  }

  /*
  * Hàm xử lý remove user trong danh sách usersRoom
  */
  private removeUsersInRoom(userId?: number) {
    if (userId && this.usersRoom) {
      const userIndex = this.usersRoom.findIndex((u) => u.userId === userId);
      const userWithRole2 = this.usersRoom.find(user => user.userId === userId);

      if (userIndex !== -1) {
        this.usersRoom.splice(userIndex, 1);
        this.changeUserRoom.emit(this.usersRoom);
      }
      if (userWithRole2?.role == 2 && this.roleUser == 1) {// xử lý khi helper out
        this.changeHelperMode.emit(false);
        this.changeHelperOut.emit(true);
        setTimeout(() => {
          this.changeHelperOut.emit(false);
        }, 4000);
      }
    }
  }

  /*
  * Hàm xử lý đổi inroom thành nút invite cho danh sách bạn bè onl
  */
  private changeBtnFriendOnl(userId: number) {
    const foundUser = this.friendsOnl?.find((friend) => friend.userId === userId);
    if (foundUser) {
      foundUser.statusInvite = 0; // 0: rảnh | 1: inroom | 2:làm quiz ng khác
    }
  }


  /*
  * Hàm xử lý đổi nút invite thành in room cho danh sách bạn bè onl
  */
  private changeInRoomFriendOnl(user: User) {
    const foundUser = this.friendsOnl?.find((friend) => friend.userId === user.userId);
    if (foundUser) {
      foundUser.statusInvite = 1;
    }
  }

  /*
  * Hàm xử lý đổi nút invite thành busy cho danh sách bạn bè onl
  */
  private changeBusyFriendOnl(user: User) {
    const foundUser = this.friendsOnl?.find((friend) => friend.userId === user.userId);
    if (foundUser) {
      foundUser.statusInvite = 2;
    }
  }

  /*
  * Hàm xử lý lọc danh sách user onl xem ai ở trong phòng thì hiển thị in room thay vì nút invite
  */
  private btnInviteFriendOnl(userId: number) {
    if (this.friendsOnl && this.usersRoom) {
      const foundUser = this.usersRoom?.find((user) => user.userId === userId);
      const foundOnl = this.friendsOnl?.find((user) => user.userId === userId);
      if (foundUser) {
        foundUser.statusInvite = 1;
      } else if (foundOnl) {
        foundOnl.statusInvite = 0;
      }
    }
  }

  /*
  * Hàm xử lý thêm userId vào friendsOff
  */
  private updateFriendListOff(userId: number) {
    // Assume userToRemove là user bạn muốn chuyển từ friendsOnl sang friendsOff
    if (this.friendsOnl && this.friendsOff) {
      const userToRemove: User | undefined = this.friendsOnl.find(user => user.userId === userId);
      if (userToRemove) {
        // Xóa user khỏi friendsOnl
        this.friendsOnl = this.friendsOnl.filter(user => user.userId !== userId);
        // Thêm user vào friendsOff
        this.friendsOff = [...this.friendsOff, userToRemove];
        this.isLoadedOff = true;
      }
    }
  }


  /*
  * Hàm xử lý thêm userId vào friendsOnl
  */
  private updateFriendListOnl(userId: number) {
    // Assume userToRemove là user bạn muốn chuyển từ friendsOff sang friendsOnl
    if (this.friendsOnl && this.friendsOff) {
      const userToRemove: User | undefined = this.friendsOff.find(user => user.userId === userId);
      if (userToRemove) {
        // Xóa user khỏi friendsOff
        this.friendsOff = this.friendsOff.filter(user => user.userId !== userId);
        userToRemove.statusInvite = 0;
        // Thêm user vào friendsOnl
        this.friendsOnl = [...this.friendsOnl, userToRemove];
        this.btnInviteFriendOnl(userId);
        this.isLoadedOnl = true;
      }
    }
  }

  /*
  * Hàm mở box gif
  */
  toggleGifGrid() {
    this.isShowSticker = !this.isShowSticker;
  }

  /*
  * Hàm mở modal user in room
  */
  openModal() {
    this.showModal = true;
  }

  /*
  * Hàm gửi lời mời làm quiz khi nhấn nút invite ở modal friends list
  */
  SendInvite(userId: number) {
    if (this.roomId)
      this.signalRService.SendInvite(userId, this.roomId);
  }

  /*
  * Hàm mở modal friends list
  */
  openModalInvite() {
    this.friendsOff = [];
    this.friendsOnl = [];
    if (this.roomId)
      this.quizService.getFriendsListRoom(this.roomId).subscribe(
        (res) => {
          if (res.status) {
            this.getImageUserOnlineFirebase(res.result.listFriendON);
            this.getImageUserOfflineFirebase(res.result.listFriendOFF);
            this.showModal = false;
            this.showModalInvite = true;
          }
        },
        (error) => {
          console.error('Lỗi khi lấy dữ liệu friends:', error);
        }
      );
  }

  /*
  * Hàm lấy ảnh cho danh sách bạn bè onl từ firebase
  */
  private async getImageUserOnlineFirebase(userRoom: User[]) {
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
                  this.friendsOnl = userRoom;
                  // this.btnInviteFriendOnl();
                  this.isLoadedOnl = true;
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
            this.friendsOnl = userRoom;
            // this.btnInviteFriendOnl();
            this.isLoadedOnl = true;

          }
        }
      });
    } else {
      this.friendsOnl = userRoom;
      // this.btnInviteFriendOnl();
      this.isLoadedOnl = true;
    }

  }


  /*
  * Hàm mở box chat
  */
  chatBoxOpen(): void {
    this.isChatBoxVisible = true;
    this.scrollToBottom();
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
  * Hàm lấy ảnh cho danh sách bạn bè off từ firebase
  */
  private async getImageUserOfflineFirebase(userRoom: User[]) {
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
                  this.friendsOff = userRoom;
                  // this.btnInviteFriendOnl();
                  this.isLoadedOff = true;
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
            this.friendsOff = userRoom;
            // this.btnInviteFriendOnl();
            this.isLoadedOff = true;
          }
        }
      });
    } else {
      this.friendsOff = userRoom;
      // this.btnInviteFriendOnl();
      this.isLoadedOff = true;

    }
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


  /*
  * Hàm xử lý nhấn vào sticker
  */
  addSelectedGif(gifSrcd: string) {
    this.gifSrc = 'assets/images/sticker-duck/';
    this.gifSrc += gifSrcd;
    if (this.roomId && this.userBoss) {
      this.signalRService.SendSticker(this.gifSrc, this.roomId);
      this.addNewChat(this.userBoss?.userId, this.gifSrc, true); // thêm chat mới
    }

    this.selectedGifs.push(this.gifSrc);

    setTimeout(() => {
      this.selectedGifs.splice(0, 1);
    }, 7000);
  }

}
