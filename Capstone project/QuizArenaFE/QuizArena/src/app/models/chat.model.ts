import { User } from "./user.model";

export class ChatData {
  constructor(
    public from: User,
    public message: string,
    public time: Date,
    public isFirstInSequence?: boolean,
    public isSticker?: boolean
  ) {}
}
