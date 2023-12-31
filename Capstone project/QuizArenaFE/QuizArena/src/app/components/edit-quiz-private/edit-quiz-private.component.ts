import { Component, ElementRef, HostListener, OnInit, Renderer2, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { faSquarePlus, faTrash, faXmark, faShareFromSquare, faTrashCan, faFloppyDisk, faShuffle, faRotateLeft } from '@fortawesome/free-solid-svg-icons';
import { switchMap } from 'rxjs';
import { QuestionData } from 'src/app/models/question-data.model';
import { Quiz } from 'src/app/models/quiz-data.model';
import { QuizSetData } from 'src/app/models/quiz-set-data.model';
import { User } from 'src/app/models/user.model';
import { ChatgptService } from 'src/app/services/chatgpt.service';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { fadeIn, fadeOutIn } from 'src/assets/animations/animation-quiz';
import { v4 as uuidv4 } from 'uuid';
import { Location } from '@angular/common';


@Component({
  selector: 'app-edit-quiz-private',
  templateUrl: './edit-quiz-private.component.html',
  styleUrls: ['./edit-quiz-private.component.scss'],
  animations: [fadeIn, fadeOutIn]
})
export class EditQuizPrivateComponent implements OnInit {
  imageUrl: string = '';
  @ViewChild('fileInput') fileInput: ElementRef | undefined;
  @ViewChild('imageSlot') imageSlot: ElementRef | undefined;
  radioText: any[] = [];
  categoryList: any[] = [];
  title: string = '';
  description: string = '';
  image?: string;
  fileImage?: File; // biến lưu giữ ảnh
  messQuiz: { title?: boolean, description?: boolean, Category?: boolean, timeLimit?: boolean } = {};
  showResult: boolean = false; // biến hiển thị kết quả add
  resultEdit: boolean = false; // biến kết quả add quiz
  quizId?: number; // biến lưu quizId
  user?: User; // biến chứa dữ liệu người dùng
  isError: boolean = false; // biến hiển thị modal lỗi trang
  messError?: string; // biến mess lỗi
  showScrollToTopButton: boolean = false; // biến hiển thị scroll
  showResultApprove: boolean = false; // biến hiển thị modal kết quả gửi duyệt quiz
  removeResult: boolean = false // biến hiển thị kết quả xóa
  showRemove: boolean = false; // biến mở modal xóa
  textQuestion: string = '';// biến lưu câu hỏi genarate
  statusGenAI: number = 0; // biến status result gen ques 0: chưa gen | 1: đang load | 2: gen succ | 3: gen faild
  notPermissionEdit: boolean = false; // biến kiểm tra quyền edit quiz
  modalRemove: boolean = false; // biến mở modal remove
  messValidate?: string; // biến hiển thị mess validate



  ///icon
  faSquarePlus = faSquarePlus;
  faShareFromSquare = faShareFromSquare;
  faTrashCan = faTrashCan;
  faFloppyDisk = faFloppyDisk;
  faTrash = faTrash;
  faXmark = faXmark;
  faShuffle = faShuffle;
  faRotateLeft = faRotateLeft;

  numberQuestionCreate: any[] = Array(3).fill(null).map((_, index) => { // biến khởi tạo question ui
    return {
      quesId: "",
      all4question: "",
      difficultyLevel: 1,
      categoryId: 1,
      correctAnswer: "",
      messError: "",
      radioTextItems: Array(4).fill(null).map((_, innerIndex) => {
        return {
          radio: { id: "", name: "", value: "" },
          textInput: { id: "", }
        };
      })
    };
  });

  quizData: QuizSetData = { quizz: {}, questions: [] }; // biến lưu data quiz cũ

  constructor(private quizDataService: QuizDataService, private userDataService: UserDataService, private renderer: Renderer2, private fireBase: FirebaseImageService,
    private route: ActivatedRoute, private quizService: QuizDataService, private router: Router, private chatgptService: ChatgptService, private location: Location) {

  }

  async ngOnInit() {
    await this.route.params.pipe(
      switchMap(params => {
        this.quizId = params['quizId'];
        return this.userDataService.userCurr;
      })
    ).subscribe(userData => {
      if (userData.userId) {
        this.user = userData;
        this.onStartQuiz();
      }
    });

  }

  genarateAI() {
    this.statusGenAI = 1;
    if (this.textQuestion && this.textQuestion.length > 0) {
      this.chatgptService.generateQuestion(this.textQuestion).subscribe(
        (response) => {
          const parsedData = JSON.parse(response);
          this.setQuestionRandom(parsedData.questions);
          this.statusGenAI = 2;
        },
        (error) => {
          this.statusGenAI = 3;
          console.error('Lỗi khi genAI question:', error);
        }
      );

    }
  }


  goBack() {
    this.location.back();
  }

  showRemoveModal() {
    this.modalRemove = true;
  }

  /*
  * Hàm set giá trị question random vào mảng question
  */
  private async setQuestionRandom(ques: any[]) {
    // Kiểm tra nếu ques không có hoặc số lượng ques ít hơn số lượng cần thiết
    if (!ques || ques.length < 1) {
      console.error("Invalid input for setQuestionRandom");
      return;
    }

    for (let i = 0; i < ques.length; i++) {
      const randomQuestion = ques[i];

      const optionsArray = randomQuestion.options.split('|');
      const radioTextItems = Array(optionsArray.length).fill(null).map((_, innerIndex) => {
        const isCorrect = innerIndex == (parseInt(randomQuestion.correctAnswer) - 1);
        return {
          radio: { id: "", name: "", value: isCorrect ? "correct" : "" },
          textInput: { id: "", name: innerIndex < optionsArray.length ? optionsArray[innerIndex] : "" }
        };
      });

      this.numberQuestionCreate.push({
        quesId: 0,
        all4question: randomQuestion.questionText || "",
        difficultyLevel: 1,
        correctAnswer: randomQuestion.correctAnswer || "",
        messError: "",
        radioTextItems: radioTextItems
      });

    }
  }


  /*
* Hàm thêm câu hỏi trống mới
*/
  addQuestionEmpty() {
    const newQuestion = {
      all4question: "",
      difficultyLevel: 1,
      correctAnswer: "",
      messError: "",
      radioTextItems: Array(4).fill(null).map((_, innerIndex) => {
        return {
          radio: { id: "", name: "", value: "" },
          textInput: { id: "", }
        };
      })
    };
    this.numberQuestionCreate.push(newQuestion);
  }


  /*
  * Hàm xóa quiz
  */
  async removeQuiz(): Promise<void> {
    //đang sửa api chưa xong
    if (this.quizData.quizz.creatorId == this.user?.userId && this.quizData.quizz.quizId) {
      await this.quizService.deleteQuiz(this.quizData.quizz.quizId, 3).subscribe(
        (response) => {
          // chặn sửa khi quiz ở trạng thái chờ duyệt hoặc đang hiển thị, hoặc quiz này do người khác tạo
          if (response.status) {
            this.removeResult = true;
            this.showRemove = true;
            setTimeout(() => {
              this.router.navigate(['/your-library']);
            }, 3000);
          } else {
            this.removeResult = false;
            this.showRemove = true;
          }
        },
        (error) => {
          this.removeResult = false;
          this.showRemove = true;
          console.error('Lỗi khi xóa quiz:', error);
        }
      );
    }

  }


  /*
  *Hàm lấy dữ liệu của quiz
  */
  async onStartQuiz() {
    // Gọi service để lấy dữ liệu quiz
    if (this.quizId)
      await this.quizService.getquiz(this.quizId).subscribe(
        (response) => {
          // chặn sửa khi quiz ở trạng thái chờ duyệt hoặc đang hiển thị, hoặc quiz này do người khác tạo
          if (response.status) {
            if (response.result.quizz.quizType != 3) {
              this.router.navigate(['/edit-quiz-staff/' + this.quizId]);
            } else {
              if (response.result.quizz.creatorId == this.user?.userId) {
                this.quizData.questions = response.result.questions;
                this.quizData.quizz = response.result.quizz;
                this.mapQuizData(response.result.quizz);
                this.mapQuestionsToNumberQuestionCreate();
              } else {
                this.isError = true;
                this.messError = 'You dont have permission edit this quiz.';
              }
            }

          }
        },
        (error) => {
          this.isError = true;
          this.messError = 'Error get infor quiz something, try again.';
          console.error('Lỗi khi lấy dữ liệu quiz:', error);
        }
      );
  }

  private mapQuizData(quiz: Quiz) {
    if (quiz.title && quiz.title?.length > 0) {
      this.title = quiz.title;
    }
    if (quiz.description && quiz.description.length > 0) {
      this.description = quiz.description;
    }
    if (quiz.image && quiz.image.length > 0) {
      this.image = quiz.image;
      this.getImageQuiz(quiz.image);
    }
  }

  private getImageQuiz(img: string) {
    this.fireBase.getImageUrl(img).subscribe(
      (url) => {
        if (url) {
          if (this.imageSlot)
            this.renderer.setProperty(this.imageSlot.nativeElement, 'innerHTML', `<img src="${url}" class="img-upload" style="width: 508px;object-fit: cover;height: 348px;border-radius:5px" alt="Selected Image">`);
        }
      },
      (error) => {
        console.error('Lỗi khi lấy URL ảnh từ Firebase:', error);
      }
    );
  }

  /*
  *Hàm map dữ liệu lấy được từ quiz vào hiển thị giao diện
  */
  private mapQuestionsToNumberQuestionCreate(): void {
    this.numberQuestionCreate = this.quizData.questions.map((question: QuestionData) => {
      const optionsArray = question.options.split('|');
      const radioTextItems = Array(optionsArray.length).fill(null).map((_, innerIndex) => {
        const isCorrect = innerIndex == (parseInt(question.correctAnswer) - 1);
        return {
          radio: { id: "", name: "", value: isCorrect ? "correct" : "" },
          textInput: { name: innerIndex < optionsArray.length ? optionsArray[innerIndex] : "" }
        };
      });

      return {
        quesId: question.questionId,
        all4question: question.questionText || "",
        difficultyLevel: question.difficultyLevel || 1,
        correctAnswer: question.correctAnswer || "",
        messError: "",
        radioTextItems: radioTextItems
      };
    });
  }

  /*
  *Hàm xử lý sự kiện xóa các đáp án
  */
  deleteRadioWithText(outerIndex: number, innerIndex: number) {
    this.numberQuestionCreate[outerIndex].radioTextItems.splice(innerIndex, 1);
    if (innerIndex == (this.numberQuestionCreate[outerIndex].correctAnswer - 1))
      this.numberQuestionCreate[outerIndex].correctAnswer = '';
  }


  /*
  *Hàm thêm một đáp án mới
  */
  addRadioTextEmpty(outerIndex: number) {
    const newItem = {
      radio: {
        id: "",
        name: "",
        value: ""
      },
      textInput: {
        id: "",
      }
    };

    this.numberQuestionCreate[outerIndex].radioTextItems.push(newItem);
  }



  /*
  *Hàm xóa câu hỏi
  */
  deleteQuestion(index: number) {
    this.numberQuestionCreate.splice(index, 1);
  }

  /*
  *Hàm check và hiển thị mess lỗi các trường của question
  */
  private updateMessError(question: any): boolean {
    // Kiểm tra nếu cả hai trường all4question và correctAnswer đều trống
    if (!question.all4question) {
      // Nếu all4question trống
      question.messError = "Question text is empty.";
      return false;
    } else if (!question.correctAnswer || question.correctAnswer.length<1) {
      // Nếu correctAnswer trống
      question.messError = "Choose the correct answer for the question.";
      return false;
    } else {
      // Nếu không có lỗi, đảm bảo messError được đặt về trạng thái rỗng
      question.messError = "";
      return true;
    }
  }

  /*
 * Hàm check các question
 */
  checkQuestion(): boolean {
    let checkResult = true;
    // Sử dụng hàm kiểm tra trong một vòng lặp hoặc bất kỳ nơi nào cần thiết
    for (let i = 0; i < this.numberQuestionCreate.length; i++) {
      const question = this.numberQuestionCreate[i];
      if (!this.updateMessError(question)) {
        checkResult = false;
      }
    }
    if (this.validateInputQuiz() && checkResult) {
      return true;
    } else {
      return false;
    }
  }



  /*
  *Hàm thay đổi đáp án đúng
  */
  onRadioValueChange(m: number, n: number, value: any) {
    // Set correctAnswer for the selected question
    this.numberQuestionCreate[m].correctAnswer = n + 1;
  }


  /*
  * Hàm xử lý update quiz
  */
  editQuiz() {
    const quizDataNew: QuizSetData = { quizz: {}, questions: [] };
    console.log(this.numberQuestionCreate);
    if (this.checkQuestion()) { // check validate các trường this.validateInputQuiz() &&
      quizDataNew.quizz.title = this.title;
      quizDataNew.quizz.description = this.description;
      quizDataNew.quizz.quizId = this.quizData.quizz.quizId;
      quizDataNew.quizz.quizType = 3;
      quizDataNew.quizz.difficultyLevel = 1;
      quizDataNew.quizz.timeLimit = 0;
      quizDataNew.quizz.status = 1;
      quizDataNew.quizz.categoryId = 0;
      if (this.fileImage) {
        const imgName = this.setImageNameUpdate();
        if (imgName && imgName.trim().length > 0)
          quizDataNew.quizz.image = `image/quiz-private/` + imgName;
      }

      for (let i = 0; i < this.numberQuestionCreate.length; i++) {
        const question = this.numberQuestionCreate[i];

        // Lấy tất cả các textInput names và join chúng thành một chuỗi bằng dấu '|'
        const options = question.radioTextItems
          .map((item: { textInput: { name: any; }; }) => item.textInput.name)
          .join('|');

        // Gán dữ liệu cho mảng questions trong quizData
        quizDataNew.questions[i] = {
          questionId: question.quesId || 0,
          questionText: question.all4question,
          difficultyLevel: Number(question.difficultyLevel),
          correctAnswer: question.correctAnswer.toString(),
          options: options
        };
      }
      console.log(quizDataNew);
      this.quizDataService.updateQuizPrivate(quizDataNew).subscribe(
        (response: any) => {
          if (response.status) {
            if (this.fileImage && quizDataNew.quizz.image) {
              this.fireBase.uploadImageQuiz(this.fileImage, quizDataNew.quizz.image);
              if (this.image && this.image?.length > 0) {
                this.fireBase.deleteImage(this.image);
              }
              this.showResult = true;
              this.resultEdit = true;
              setTimeout(() => {
                this.router.navigate(['/quiz-private-detail', this.quizId]);
              }, 3000);
            } else {
              this.showResult = true;
              this.resultEdit = true;
              setTimeout(() => {
                this.router.navigate(['/quiz-private-detail', this.quizId]);
              }, 3000);
            }
          } else {
            this.showResult = true;
            this.resultEdit = false;
            console.error('Lỗi edit quiz:', response.message);
          }
        },
        (error) => {
          this.showResult = true;
          this.resultEdit = false;
          console.error('Lỗi edit quiz:', error);
        }
      );
    }
  }

  /*
  *Hàm set tên ảnh theo mã guid
  */
  private setImageNameUpdate(): string {
    const newGuid = uuidv4();
    let fileName: string = '';
    if (this.fileImage) {
      if (this.fileImage.type == 'image/jpeg') {
        fileName = newGuid + '.jpg';
      }
      if (this.fileImage.type == 'image/png') {
        fileName = newGuid + '.png';
      }
    }
    return fileName;
  }



  /*
  * Hàm kiểm tra dữ liệu và các trường
  */
  validateInputQuiz(): boolean {
    let checkResult = true;
    if (!this.title || this.title.length < 1) {
      this.messQuiz.title = true;
      this.messValidate = 'Title is not empty.';
      checkResult = false;
    } else {
      this.messQuiz.title = false;
    }
    if (!this.description || this.description.length < 10) {
      this.messQuiz.description = true;
      this.messValidate = 'Description is not empty.';
      checkResult = false;
    } else {
      this.messQuiz.description = false;
    }
    if (!this.numberQuestionCreate || this.numberQuestionCreate.length < 2) {
      this.messValidate = 'There must be a minimum of two questions.';
      checkResult = false;
    }
    if (checkResult)
      this.messValidate = '';
    return checkResult;
  }


  /*
  * Hàm mở cửa sổ chọn file
  */
  openFileInput() {
    if (this.fileInput)
      this.renderer.selectRootElement(this.fileInput.nativeElement).click();
  }




  /*
  * Hàm load ảnh
  */
  handleFileInput(event: any) {
    const fileInput = event.target;

    if (fileInput.files && fileInput.files[0]) {
      const reader = new FileReader();
      reader.onload = (e: any) => {
        if (this.imageSlot)
          this.renderer.setProperty(this.imageSlot.nativeElement, 'innerHTML', `<img src="${e.target.result}" class="img-upload" style="width: 508px;object-fit: cover;height: 348px;border-radius:5px" alt="Selected Image">`);
      };
      this.fileImage = fileInput.files[0];
      reader.readAsDataURL(fileInput.files[0]);
    }
  }

  /*
  * Hàm nhận sự kiện kéo xuống hiện nút scroll
  */
  @HostListener('window:scroll', [])
  onWindowScroll() {
    const scrollPosition = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;

    // Hiển thị nút khi scroll xuống một khoảng nhất định, ví dụ, 200px
    this.showScrollToTopButton = scrollPosition > 300;
  }

  /*
  * Hàm scroll top tự động
  */
  scrollToTop() {
    window.scrollTo({ top: 0, behavior: 'smooth' }); // Sử dụng 'smooth' để có hiệu ứng cuộn mượt
  }

}
