import CommonConstants from "../common/constants/CommonConstants"

export default class PostModel {
  id:number = -1
  userName:string = CommonConstants.DEFAULT_USERNAME
  userPicture:string = CommonConstants.DEFAULT_AVATOR
  postTitle:string =  ''
  postBody:string =  ''
  commentNum:number = 0
  likeNum:number = 0
  isLiked:string = 'false'
  commentStr:string = ''
}
