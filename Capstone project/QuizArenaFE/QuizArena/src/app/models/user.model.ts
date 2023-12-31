export class User {
  constructor(
    public userId: number,
    public fullname: string,
    public username: string,
    public email: string,
    public role: number,
    public images: string,
    public description: string,
    public score: number,
    public exp: number,
    public created_at: Date,
    public statusInvite: number,
    public activityType:number
  ) {}
}
