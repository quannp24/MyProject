export class UserUpdate {
  constructor(
    public fullname?: string,
    public email?: string,
    public images?: string,
    public description?: string,
    public exp?: number
  ) { }
}
