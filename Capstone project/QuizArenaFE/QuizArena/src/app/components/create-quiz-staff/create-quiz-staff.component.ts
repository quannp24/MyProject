import { Component, ElementRef, HostListener, Renderer2, ViewChild } from '@angular/core';
import { faSquarePlus, faTrash, faXmark, faRotateLeft, faMagnifyingGlass } from '@fortawesome/free-solid-svg-icons';
import { QuestionData } from 'src/app/models/question-data.model';
import { QuizSetData } from 'src/app/models/quiz-set-data.model';
import { FirebaseImageService } from 'src/app/services/firebase-image.service';
import { QuizDataService } from 'src/app/services/quiz-data.service';
import { UserDataService } from 'src/app/services/user-data.service';
import { fadeIn, fadeOutIn } from 'src/assets/animations/animation-quiz';
import { v4 as uuidv4 } from 'uuid';

@Component({
  selector: 'app-create-quiz-staff',
  templateUrl: './create-quiz-staff.component.html',
  styleUrls: ['./create-quiz-staff.component.scss'],
  animations: [fadeOutIn, fadeIn]
})
export class CreateQuizStaffComponent {
  imageUrl: string = '';
  @ViewChild('fileInput') fileInput: ElementRef | undefined;
  @ViewChild('imageSlot') imageSlot: ElementRef | undefined;
  radioText: any[] = [];
  categoryList: any[] = [];
  selectedCategoryId: number = 1;
  selectedDifficultyLevel: number = 1;
  timeLimit?: string;
  selectedTypeQuiz: string = "1";
  title: string = '';
  description: string = '';
  image?: string;
  selectedOption: string = '';
  selectedRadioValue: string = '';
  questionText: string = ''
  DifficultyQuestion: any
  correctAnswer: string = "";
  displayTimeLimit: boolean = false;
  isCanSubmit: boolean = false; // biến xác định được add quiz hay chưa
  fileImage?: File; // biến lưu giữ ảnh
  messQuiz: { title?: boolean, description?: boolean, Category?: boolean, timeLimit?: boolean } = {};
  showResult: boolean = false; // biến hiển thị kết quả add
  resultAdd: boolean = false; // biến kết quả add quiz
  showGenModal: boolean = false;//biến hiển thị modal gen ques
  categoryGenQues: number = 1; // biến lựa chọn category gen ques
  numLv1: number = 0; // biến lưu số ques lv 1 muốn gen ra
  numLv2: number = 0;// biến lưu số ques lv 2 muốn gen ra
  numLv3: number = 0;// biến lưu số ques lv 3 muốn gen ra
  undoGenQues: boolean = false; // biến hiển thị button undo gen
  private previousState: any[] = [];
  showScrollToTopButton: boolean = false; // biến hiển thị scroll
  showAddQuestion: boolean = false; // biến hiển thị modal add question

  loading: boolean = true;
  questionList: QuestionData[] = [];


  selectedQuestion!: QuestionData[];


  ///icon
  faSquarePlus = faSquarePlus;
  faTrash = faTrash;
  faXmark = faXmark;
  faRotateLeft = faRotateLeft;
  faMagnifyingGlass = faMagnifyingGlass;

  numberQuestionCreate: any[] = Array(0).fill(null).map((_, index) => { // biến khởi tạo question ui
    return {
      questionId: 0,
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


  constructor(private quizDataService: QuizDataService, private userDataService: UserDataService, private renderer: Renderer2, private fireBase: FirebaseImageService) { }

  async ngOnInit() {
    await this.userDataService.userCurr.subscribe(user => {
      if (user.userId) {
        this.quizDataService.getCategory().subscribe(res => {
          this.categoryList = res.result;
        });
      }
    });
  }

  private setupQuestionList(ques: any[]) {
    // Lọc ra những câu hỏi không có questionId trong mảng numberQuestionCreate
    const filteredQuestions = ques.filter(question => {
      return !this.numberQuestionCreate.some(createQuestion => createQuestion.quesId === question.questionId);
    });

    this.questionList = filteredQuestions;
    this.loading = false;
  }


  addQuestionBank() {
    this.setQuestionBank(this.selectedQuestion);
    this.selectedQuestion = [];
    this.showAddQuestion = false;
  }

  /*
  * Hàm show modal gen question
  */
  showGenerateQues() {
    this.showGenModal = true;
  }

  /*
  * Hàm quay lại trước khi gen question
  */
  undoGen() {
    if (this.previousState.length > 0) {
      this.numberQuestionCreate = this.previousState.map(question => ({ ...question }));
      this.previousState = [];
      this.undoGenQues = false;
    }
  }

  /*
  * Hàm lấy question random
  */
  generateQuestions() {
    // Lưu trạng thái trước khi thêm câu hỏi random
    this.previousState = this.numberQuestionCreate.map(question => ({ ...question }));

    if (this.numLv1 != 0 || this.numLv2 != 0 || this.numLv3 != 0) {
      this.quizDataService.getRandomQuestion(this.categoryGenQues, this.numLv1, this.numLv2, this.numLv3).subscribe(
        (response: any) => {
          if (response.status) {
            this.setQuestionRandom(response.result);
            console.log(response.result)
          }
        },
        (error) => {
          console.error('Lỗi gen question:', error);
        }
      );
    } else {
      console.log('empty')
    }
  }

  /*
  * Hàm set giá trị question random vào mảng question
  */
  private async setQuestionBank(ques: QuestionData[]) {
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
        questionId: randomQuestion.questionId,
        all4question: randomQuestion.questionText || "",
        categoryId: this.selectedCategoryId || 1,
        difficultyLevel: randomQuestion.difficultyLevel || 1,
        correctAnswer: randomQuestion.correctAnswer || "",
        messError: "",
        radioTextItems: radioTextItems
      });

    }
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

      const optionsArray = randomQuestion.Options.split('|');
      const radioTextItems = Array(optionsArray.length).fill(null).map((_, innerIndex) => {
        const isCorrect = innerIndex == (parseInt(randomQuestion.CorrectAnswer) - 1);
        return {
          radio: { id: "", name: "", value: isCorrect ? "correct" : "" },
          textInput: { id: "", name: innerIndex < optionsArray.length ? optionsArray[innerIndex] : "" }
        };
      });

      this.numberQuestionCreate.push({
        questionId: randomQuestion.QuestionId,
        all4question: randomQuestion.QuestionText || "",
        categoryId: randomQuestion.CategoryId || 1,
        difficultyLevel: randomQuestion.DifficultyLevel || 1,
        correctAnswer: randomQuestion.CorrectAnswer || "",
        messError: "",
        radioTextItems: radioTextItems
      });

    }
    this.undoGenQues = true;
  }


  ShowaddQuestion() {
    this.showAddQuestion = true;
    this.quizDataService.getQuestionsByCategory(this.selectedCategoryId, 1, undefined).subscribe(
      (response: any) => {
        if (response.status) {
          this.setupQuestionList(response.result);
        }
      },
      (error) => {
        console.error('Lỗi lấy list question:', error);
      }
    );
  }


  /*
  * Hàm thêm câu hỏi trống mới
  */
  addQuestionEmpty() {
    const newQuestion = {
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
    this.numberQuestionCreate.push(newQuestion);
  }

  /*
  * Hàm xóa question
  */
  deleteQuestion(index: number) {
    this.numberQuestionCreate.splice(index, 1);
  }


  /*
  *Hàm check và hiển thị mess lỗi các trường question
  */
  private updateMessError(question: any): boolean {
    // Kiểm tra nếu cả hai trường all4question và correctAnswer đều trống
    if (!question.all4question) {
      // Nếu all4question trống
      question.messError = "Question text is empty.";
      return false;
    } else if (!question.correctAnswer) {
      // Nếu correctAnswer trống
      question.messError = "Choose the correct answer for the question.";
      return false;
    } else if (question.categoryId != this.selectedCategoryId) {
      // Nếu correctAnswer trống
      question.messError = "The category of this question is different from the category quiz.";
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
  * Hàm set lại giá trị corect answer khi tích radio
  */
  onRadioValueChange(m: number, n: number, value: any) {
    // Set correctAnswer for the selected question
    this.numberQuestionCreate[m].correctAnswer = n + 1;
  }


  /*
  * Hàm xử lý thêm mới quiz
  */
  addQuiz() {
    const quizData: QuizSetData = { quizz: {}, questions: [] }; // biến lưu data quiz
    if (this.checkQuestion()) { // check validate các trường this.validateInputQuiz() &&
      quizData.quizz.title = this.title;
      quizData.quizz.description = this.description;
      quizData.quizz.status = 0;
      quizData.quizz.quizType = Number(this.selectedTypeQuiz);
      quizData.quizz.difficultyLevel = Number(this.selectedDifficultyLevel);
      quizData.quizz.timeLimit = Number(this.timeLimit);
      if (this.selectedTypeQuiz.includes('2')) {
        quizData.quizz.timeLimit = Number(this.timeLimit);
        quizData.quizz.categoryId = 0;
      } else {
        quizData.quizz.timeLimit = 0;
        quizData.quizz.categoryId = this.selectedCategoryId;
      }
      if (this.fileImage && this.image) {
        const imgName = this.setImageNameUpdate();
        if (imgName && imgName.trim().length > 0)
          quizData.quizz.image = `image/quiz-practice/` + imgName;
      }

      for (let i = 0; i < this.numberQuestionCreate.length; i++) {
        const question = this.numberQuestionCreate[i];

        // Lấy tất cả các textInput names và join chúng thành một chuỗi bằng dấu '|'
        const options = question.radioTextItems
          .map((item: { textInput: { name: any; }; }) => item.textInput.name)
          .join('|');

        // Gán dữ liệu cho mảng questions trong quizData
        quizData.questions[i] = {
          questionId: question.questionId,
          questionText: question.all4question,
          difficultyLevel: Number(question.difficultyLevel),
          correctAnswer: question.correctAnswer.toString(),
          options: options
        };
      }
      console.log(quizData);
      this.quizDataService.addQuiz(quizData).subscribe(
        (response: any) => {
          if (response.status) {
            if (this.fileImage && quizData.quizz.image) {
              this.fireBase.uploadImageQuiz(this.fileImage, quizData.quizz.image);
            }
            this.showResult = true;
            this.resultAdd = true;
          } else {
            this.showResult = true;
            this.resultAdd = false;
            console.error('Lỗi add quiz:', response.message);
          }
        },
        (error) => {
          this.showResult = true;
          this.resultAdd = false;
          console.error('Lỗi add quiz:', error);
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
      checkResult = false;
    } else {
      this.messQuiz.title = false;
    }
    if (!this.description || this.description.length < 100) {
      this.messQuiz.description = true;
      checkResult = false;
    } else {
      this.messQuiz.description = false;
    }
    if (this.selectedTypeQuiz.includes('2') && !this.timeLimit) {
      this.messQuiz.timeLimit = true;
      checkResult = false;
    } else {
      if (this.timeLimit && /^\d+$/.test(this.timeLimit))
        this.messQuiz.timeLimit = false;
    }
    return checkResult;
  }


  /*
  * Hàm show time limit khi thay đổi type quiz
  */
  onQuizTypeChange() {
    if (this.selectedTypeQuiz === "1") {
      this.displayTimeLimit = false;
    } else {
      this.displayTimeLimit = true;
    }
  }

  /*
  * Hàm mở cửa sổ chọn file
  */
  openFileInput() {
    if (this.fileInput)
      this.renderer.selectRootElement(this.fileInput.nativeElement).click();
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


  /*
  * Hàm load ảnh
  */
  handleFileInput(event: any) {
    const fileInput = event.target;

    if (fileInput.files && fileInput.files[0]) {
      const reader = new FileReader();
      this.image = fileInput.files[0].name;
      reader.onload = (e: any) => {
        if (this.imageSlot)
          this.renderer.setProperty(this.imageSlot.nativeElement, 'innerHTML', `<img src="${e.target.result}" class="img-upload" style="width: 508px;object-fit: cover;height: 348px;border-radius:5px" alt="Selected Image">`);
      };
      this.fileImage = fileInput.files[0];
      reader.readAsDataURL(fileInput.files[0]);
    }
  }

}
