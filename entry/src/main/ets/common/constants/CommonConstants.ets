import { relationalStore } from '@kit.ArkData';
import { AccountTable, PostTable } from '../../viewmodel/ConstantsInterface';

export default class CommonConstants {
  /**
   * Rdb database config.
   */
  static readonly STORE_CONFIG: relationalStore.StoreConfig = {
    name: 'database.db',
    securityLevel: relationalStore.SecurityLevel.S1
  };
  /**
   * Account table config.
   */
  static readonly ACCOUNT_TABLE: AccountTable = {
    tableName: 'accountTable',
    sqlCreate: 'CREATE TABLE IF NOT EXISTS accountTable(id INTEGER PRIMARY KEY AUTOINCREMENT, accountType INTEGER, ' +
      'typeText TEXT, amount INTEGER)',
    columns: ['id', 'accountType', 'typeText', 'amount']
  };

  /**
   * post表配置
   */
  static readonly POST_TABLE: PostTable = {
    tableName: 'postTable',
    sqlCreate: 'CREATE TABLE IF NOT EXISTS postTable (\n' +
      '  id INTEGER PRIMARY KEY AUTOINCREMENT,\n' +
      '  userName TEXT,\n' +
      '  userPicture TEXT,\n' +
      '  postTitle TEXT,\n' +
      '  postBody TEXT,\n' +
      '  commentNum INTEGER DEFAULT 0,\n' +
      '  likeNum INTEGER DEFAULT 0,\n' +
      '  isLiked TEXT,\n' +
      '  commentStr TEXT\n' +
      ')',
    columns: ['id', 'userName', 'userPicture', 'postTitle','postBody','commentNum','likeNum','isLiked','commentStr']
  };
  /**
   * Search text of Search component.
   */
  static readonly SEARCH_TEXT = '搜索';
  /**
   * toast text of prompt component.
   */
  static readonly TOAST_TEXT_1 = '账目类型不能为空';
  static readonly TOAST_TEXT_2 = '账目金额不为正整数';
  /**
   * Component size.
   */
  static readonly FULL_WIDTH = '100%';
  static readonly FULL_HEIGHT = '100%';
  static readonly DIALOG_HEIGHT = '55%';
  static readonly DIALOG_HEIGHT_2 = '75%';
  static readonly COMPONENT_SIZE_M = '40%';
  static readonly TABS_HEIGHT = '45%';
  static readonly MINIMUM_SIZE = 0;
  static readonly FULL_SIZE = 1;
  static readonly PROMPT_BOTTOM = '70vp';
  /**
   * Component location.
   */
  static readonly EDIT_POSITION_X = '80%';
  static readonly EDIT_POSITION_Y = '90%';
  static readonly DELETE_POSITION_X = '50%';
  static readonly DELETE_POSITION_Y = '90%';
  /**
   * Log tag.
   */
  static readonly RDB_TAG = '[Debug.Rdb]';
  static readonly TABLE_TAG_ACOUNTTABLE = '[Debug.AccountTable]';
  static readonly TABLE_TAG_POSTTABLE = '[Debug.AccountTable]';
  static readonly INDEX_TAG = '[Debug.Index]';
  /**
   * 默认数据
   */
  static DEFAULT_USERNAME = '默认用户名'
  static DEFAULT_AVATOR = 'app.media.default_avator'
}