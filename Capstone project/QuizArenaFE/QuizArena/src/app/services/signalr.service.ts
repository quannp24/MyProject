import { Injectable } from '@angular/core';
import * as signalR from '@microsoft/signalr';
import { BehaviorSubject, Subject } from 'rxjs';


@Injectable({
  providedIn: 'root'
})
export class SignalrService {
  private hubConnection?: signalR.HubConnection;
  public isConnectedSubject = new BehaviorSubject<boolean>(false);

  constructor() { }

  public async startConnection(userId: number) {
    this.hubConnection = new signalR.HubConnectionBuilder()
      .withUrl('https://localhost:7088/doquizhub?userId=' + userId)
      .build();
    if (this.hubConnection) {
      try {
        await this.hubConnection.start().then(() => {
          this.isConnectedSubject.next(true); // Đặt giá trị isConnected thành true
        });
        console.log("connected.");
      } catch (error) {
        console.error(error);
      }
    }
  }

  getHubConnection = () => this.hubConnection;

  //===========CALL FUNCATION HUB SIGNALR=============

  joinRoom(roomId: string): void {
    if (this.hubConnection)
      this.hubConnection.invoke('JoinRoom', roomId);
  }

  SendInvite(friendId: number, roomId: String): void {
    if (this.hubConnection)
      this.hubConnection.invoke('SendInviteQuiz', friendId, roomId);
  }

  OutRoomQuiz(roomId: string): void {
    if (this.hubConnection)
      this.hubConnection.invoke('OutRoomQuiz', roomId);
  }

  DoAgainQuiz(roomId: string): void {
    if (this.hubConnection)
      this.hubConnection.invoke('DoAgainQuiz', roomId);
  }

  SendAnswerSelected(answer: number, roomId: string, totalExp: number, currentQuestion: number, numberCorrect: number): void {
    if (this.hubConnection)
      this.hubConnection.invoke('SendAnswer', answer, roomId, totalExp, currentQuestion, numberCorrect);
  }

  SendMessages(message: string, roomId: string): void {
    if (this.hubConnection)
      this.hubConnection.invoke('SendMessages', message, roomId);
  }

  SendSticker(message: string, roomId: string): void {
    if (this.hubConnection)
      this.hubConnection.invoke('SendStickers', message, roomId);
  }

  AddHelper(roomId: string, userId: number): void {
    if (this.hubConnection)
      this.hubConnection.invoke('AddHelper', roomId, userId);
  }

  RemoveHelper(roomId: string, userId: number): void {
    if (this.hubConnection)
      this.hubConnection.invoke('RemoveHelper', roomId, userId);
  }

  //===========LISTEN EVENT SIGNALR=============

  ReceivedRemoveHelper(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('SendRemoveHelper', callback);
    }
  }

  ReceivedChangeHelper(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('ChangeHelper', callback);
    }
  }

  ReceivedSticker(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('SendStickerToRoom', callback);
    }
  }

  ReceivedMessage(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('SendMessageToRoom', callback);
    }
  }

  ReceivedAnswerSelected(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('AnswerSelected', callback);
    }
  }

  ReceivedEventDoAgain(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('SendEventDoAgainQuiz', callback);
    }
  }

  UserJoinRoom(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('UserJoin', callback);
    }
  }

  ListenFriendJoinMyRoom(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('FriendJoinMyRoom', callback);
    }
  }

  ListenFriendJoinOrtherRoom(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('FriendJoinRoomOrther', callback);
    }
  }

  ListenUserOutRoom(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('UserRoomOut', callback);
    }
  }


  NotifyInviteDoQuiz(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('InviteDoQuiz', callback);
    }
  }

  ListenFriendOff(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('NotifyFriendOffline', callback);
    }
  }

  ListenFriendOnl(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('NotifyFriendOnlline', callback);
    }
  }

  //====================CHALLENGE============================

  OutLobbyChallenge(examId: string): void {
    if (this.hubConnection)
      this.hubConnection.invoke('OutLobbyChallenge', examId);
  }

  joinLobbyChallenge(examId: string): void {
    if (this.hubConnection)
      this.hubConnection.invoke('JoinLobbyChallenge', examId);
  }

  joinChallenge(examId: string): void {
    if (this.hubConnection)
      this.hubConnection.invoke('JoinChallenge', examId);
  }

  SendMessagesLobby(message: string, examId: string): void {
    if (this.hubConnection)
      this.hubConnection.invoke('SendMessagesLobby', message, examId);
  }

  SendStickerLobby(message: string, examId: string): void {
    if (this.hubConnection)
      this.hubConnection.invoke('SendStickersLobby', message, examId);
  }



  //-------------LISTEN EVENT---------------------
  ListenUserJoinLobby(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('SendUserJoinLobby', callback);
    }
  }

  ListenTimeOut(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('TimeOut', callback);
    }
  }

  ListenJoinChallenge(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('SendUserJoinChallenge', callback);
    }
  }

  ListenUserOutLobby(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('SendUserOutLobby', callback);
    }
  }

  ReceivedStickerLobby(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('SendStickerToLobby', callback);
    }
  }

  ReceivedMessageLobby(callback: (data: any) => void): void {
    if (this.hubConnection) {
      this.hubConnection.on('SendMessageToLobby', callback);
    }
  }

  isConnected(): boolean {
    return this.hubConnection?.state === 'Connected';
  }
}
