abstract class SocialStates{}

class SocialInitiliteStates extends SocialStates{}
class SocialGetUserScussesState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
  final String e;

  SocialGetUserErrorState(this.e);

}
class SocialGetUserLoadingState extends SocialStates{}
class SocialChangeBootomState extends SocialStates{}
class SocialAddNewPostState extends SocialStates{}

class SocialCoverImageScussesState extends SocialStates{}
class SocialCoverImageErrorState extends SocialStates{

}

class SocialUploadCoverImageScussesState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}


class SocialProfileImageScussesState extends SocialStates{}
class SocialProfileImageErrorState extends SocialStates{}

class SocialUploadProfileImageScussesState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUpdateUserErrorState extends SocialStates{
  final String e;

  SocialUpdateUserErrorState(this.e);

}
class SocialUploadProfileImageLoadibngState extends SocialStates{}




//craete post
class SocialCreatePostErrorState extends SocialStates{
  final String e;

  SocialCreatePostErrorState(this.e);

}
class SocialCreatePostImageLoadibngState extends SocialStates{}
class SocialCreatePostImageScussesState extends SocialStates{}

class SocialPostImageScussesState extends SocialStates{}
class SocialPostImageErrorState extends SocialStates{}
class SocialRemovePostImageErrorState extends SocialStates{}

//get post
class SocialGetPOstUserScussesState extends SocialStates{}
class SocialGetPostUserErrorState extends SocialStates{
  final String e;

  SocialGetPostUserErrorState(this.e);

}
class SocialGetPostUserLoadingState extends SocialStates{}

//liked post
class SocialLikePOstUserScussesState extends SocialStates{}
class SocialLikePostUserErrorState extends SocialStates{
  final String e;

  SocialLikePostUserErrorState(this.e);

}
class SocialLikePostUserLoadingState extends SocialStates{}


//comment post
class SocialCommentPOstUserScussesState extends SocialStates{}
class SocialCommentPostUserErrorState extends SocialStates{
  final String e;

  SocialCommentPostUserErrorState(this.e);

}
class SocialCommentPostUserLoadingState extends SocialStates{}

//get all user
class SocialGetAllUserScussesState extends SocialStates{}
class SocialGetAllUserErrorState extends SocialStates{
  final String e;

  SocialGetAllUserErrorState(this.e);

}
class SocialGetAllUserLoadingState extends SocialStates{}

//chat
class SocialSendMassageScussesState extends SocialStates{}
class SocialSendMassageErrorState extends SocialStates{
  final String e;

  SocialSendMassageErrorState(this.e);

}
class SocialGetMassageScussesState extends SocialStates{}
class SocialGetMassageErrorState extends SocialStates{
  final String e;

  SocialGetMassageErrorState(this.e);

}