import { relationalStore } from '@kit.ArkData';
import AccountData from '../../../viewmodel/AccountData';
import  PostModel  from '../../../viewmodel/PostModel';
import CommonConstants from '../../constants/CommonConstants';
import Rdb from '../Rdb';

export default class PostTable {
  private postTable = new Rdb(CommonConstants.POST_TABLE.tableName, CommonConstants.POST_TABLE.sqlCreate,
    CommonConstants.POST_TABLE.columns);

  constructor(callback: Function = () => {
  }) {
    this.postTable.getRdbStore(callback);
  }

  getRdbStore(callback: Function = () => {
  }) {
    this.postTable.getRdbStore(callback);
  }

  insertData(post: PostModel, callback: Function) {
    const valueBucket: relationalStore.ValuesBucket = generateBucket(post);
    this.postTable.insertData(valueBucket, callback);
  }

  deleteData(post: PostModel, callback: Function) {
    let predicates = new relationalStore.RdbPredicates(CommonConstants.POST_TABLE.tableName);
    predicates.equalTo('id', post.id);
    this.postTable.deleteData(predicates, callback);
  }

  updateData(post: PostModel, callback: Function) {
    const valueBucket: relationalStore.ValuesBucket = generateBucket(post);
    let predicates = new relationalStore.RdbPredicates(CommonConstants.POST_TABLE.tableName);
    predicates.equalTo('id', post.id);
    this.postTable.updateData(predicates, valueBucket, callback);
  }

  //查询id或全部
  query(id: number, callback: Function, isAll: boolean = true) {
    let predicates = new relationalStore.RdbPredicates(CommonConstants.POST_TABLE.tableName);
    if (!isAll) {
      predicates.equalTo('id', id);
    }
    this.postTable.query(predicates, (resultSet: relationalStore.ResultSet) => {
      let count: number = resultSet.rowCount;
      if (count === 0 || typeof count === 'string') {
        console.log(`${CommonConstants.TABLE_TAG_POSTTABLE}` + 'Query no results!');
        callback([]);
      } else {
        resultSet.goToFirstRow();
        const result: PostModel[] = [];
        for (let i = 0; i < count; i++) {
          let tmp: PostModel = {
            id:0,
            userName: '',
            userPicture: '',
            postTitle: '',
            postBody: '',
            commentNum: 0,
            likeNum: 0,
            isLiked: 'false',
            commentStr: ''
          };
          tmp.id = resultSet.getDouble(resultSet.getColumnIndex('id'));
          tmp.userName = resultSet.getString(resultSet.getColumnIndex('userName'));
          tmp.userPicture = resultSet.getString(resultSet.getColumnIndex('userPicture'));
          tmp.postTitle = resultSet.getString(resultSet.getColumnIndex('postTitle'));
          tmp.postBody = resultSet.getString(resultSet.getColumnIndex('postBody'));
          tmp.commentNum = resultSet.getDouble(resultSet.getColumnIndex('commentNum'));
          tmp.likeNum = resultSet.getDouble(resultSet.getColumnIndex('likeNum'));
          tmp.isLiked = resultSet.getString(resultSet.getColumnIndex('isLiked'));
          tmp.commentStr = resultSet.getString(resultSet.getColumnIndex('commentStr'));

          result[i] = tmp;
          resultSet.goToNextRow();
        }
        callback(result);
      }
    });
  }
}

function generateBucket(post: PostModel): relationalStore.ValuesBucket {
  let obj: relationalStore.ValuesBucket = {};
  obj.userName = post.userName;
  obj.userPicture = post.userPicture;
  obj.postTitle = post.postTitle;
  obj.postBody = post.postBody;
  obj.commentNum = post.commentNum;
  obj.likeNum = post.likeNum;
  obj.isLiked = post.isLiked;
  obj.commentStr = post.commentStr;
  return obj;
}