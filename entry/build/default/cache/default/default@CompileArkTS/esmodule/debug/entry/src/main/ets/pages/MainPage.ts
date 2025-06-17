if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface MainPage_Params {
    accounts?: Array<AccountData>;
    searchText?: string;
    isEdit?: boolean;
    isInsert?: boolean;
    newAccount?: AccountData;
    index?: number;
    item?: AccountData;
    AccountTable?;
    deleteList?: Array<AccountData>;
    searchController?: SearchController;
    dialogController?: CustomDialogController;
    /**
     * post弹窗
     * @param item
     */
    postDialog?: CustomDialogController;
}
import AccountTable from "@bundle:com.example.rdb/entry/ets/common/database/tables/AccountTable";
import type AccountData from '../viewmodel/AccountData';
import CommonConstants from "@bundle:com.example.rdb/entry/ets/common/constants/CommonConstants";
import { DialogComponent } from "@bundle:com.example.rdb/entry/ets/view/DialogComponent";
import { ImageList } from "@bundle:com.example.rdb/entry/ets/viewmodel/AccountList";
import Logger from "@bundle:com.example.rdb/entry/ets/common/utils/Logger";
import { PostingDialog } from "@bundle:com.example.rdb/entry/ets/view/PostingDialog";
class MainPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__accounts = new ObservedPropertyObjectPU([], this, "accounts");
        this.__searchText = new ObservedPropertySimplePU('', this, "searchText");
        this.__isEdit = new ObservedPropertySimplePU(false, this, "isEdit");
        this.__isInsert = new ObservedPropertySimplePU(false, this, "isInsert");
        this.__newAccount = new ObservedPropertyObjectPU({
            id: 0,
            accountType: 0,
            typeText: '',
            amount: 0
        }, this, "newAccount");
        this.__index = new ObservedPropertySimplePU(-1, this, "index");
        this.__item = new ObservedPropertyObjectPU({
            id: 0,
            accountType: 0,
            typeText: '',
            amount: 0
        }, this, "item");
        this.AccountTable = new AccountTable(() => {
        });
        this.deleteList = [];
        this.searchController = new SearchController();
        this.dialogController = new CustomDialogController({
            builder: () => {
                let jsDialog = new DialogComponent(this, {
                    isInsert: this.__isInsert,
                    newAccount: this.__newAccount,
                    confirm: (isInsert: boolean, newAccount: AccountData) => this.accept(isInsert, newAccount)
                }, undefined, -1, () => { }, { page: "entry/src/main/ets/pages/MainPage.ets", line: 38, col: 14 });
                jsDialog.setController(this.dialogController);
                ViewPU.create(jsDialog);
                let paramsLambda = () => {
                    return {
                        isInsert: this.__isInsert,
                        newAccount: this.__newAccount,
                        confirm: (isInsert: boolean, newAccount: AccountData) => this.accept(isInsert, newAccount)
                    };
                };
                jsDialog.paramsGenerator_ = paramsLambda;
            },
            customStyle: true,
            alignment: DialogAlignment.Bottom
        }, this);
        this.postDialog = new CustomDialogController({
            builder: () => {
                let jsDialog = new PostingDialog(this, {
                    item: this.item,
                }, undefined, -1, () => { }, { page: "entry/src/main/ets/pages/MainPage.ets", line: 52, col: 14 });
                jsDialog.setController(this.
                /**
                 * post弹窗
                 * @param item
                 */
                postDialog);
                ViewPU.create(jsDialog);
                let paramsLambda = () => {
                    return {
                        item: this.item
                    };
                };
                jsDialog.paramsGenerator_ = paramsLambda;
            },
            customStyle: true,
            alignment: DialogAlignment.Bottom
        }, this);
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: MainPage_Params) {
        if (params.accounts !== undefined) {
            this.accounts = params.accounts;
        }
        if (params.searchText !== undefined) {
            this.searchText = params.searchText;
        }
        if (params.isEdit !== undefined) {
            this.isEdit = params.isEdit;
        }
        if (params.isInsert !== undefined) {
            this.isInsert = params.isInsert;
        }
        if (params.newAccount !== undefined) {
            this.newAccount = params.newAccount;
        }
        if (params.index !== undefined) {
            this.index = params.index;
        }
        if (params.item !== undefined) {
            this.item = params.item;
        }
        if (params.AccountTable !== undefined) {
            this.AccountTable = params.AccountTable;
        }
        if (params.deleteList !== undefined) {
            this.deleteList = params.deleteList;
        }
        if (params.searchController !== undefined) {
            this.searchController = params.searchController;
        }
        if (params.dialogController !== undefined) {
            this.dialogController = params.dialogController;
        }
        if (params.postDialog !== undefined) {
            this.postDialog = params.postDialog;
        }
    }
    updateStateVars(params: MainPage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__accounts.purgeDependencyOnElmtId(rmElmtId);
        this.__searchText.purgeDependencyOnElmtId(rmElmtId);
        this.__isEdit.purgeDependencyOnElmtId(rmElmtId);
        this.__isInsert.purgeDependencyOnElmtId(rmElmtId);
        this.__newAccount.purgeDependencyOnElmtId(rmElmtId);
        this.__index.purgeDependencyOnElmtId(rmElmtId);
        this.__item.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__accounts.aboutToBeDeleted();
        this.__searchText.aboutToBeDeleted();
        this.__isEdit.aboutToBeDeleted();
        this.__isInsert.aboutToBeDeleted();
        this.__newAccount.aboutToBeDeleted();
        this.__index.aboutToBeDeleted();
        this.__item.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __accounts: ObservedPropertyObjectPU<Array<AccountData>>;
    get accounts() {
        return this.__accounts.get();
    }
    set accounts(newValue: Array<AccountData>) {
        this.__accounts.set(newValue);
    }
    private __searchText: ObservedPropertySimplePU<string>;
    get searchText() {
        return this.__searchText.get();
    }
    set searchText(newValue: string) {
        this.__searchText.set(newValue);
    }
    private __isEdit: ObservedPropertySimplePU<boolean>;
    get isEdit() {
        return this.__isEdit.get();
    }
    set isEdit(newValue: boolean) {
        this.__isEdit.set(newValue);
    }
    private __isInsert: ObservedPropertySimplePU<boolean>;
    get isInsert() {
        return this.__isInsert.get();
    }
    set isInsert(newValue: boolean) {
        this.__isInsert.set(newValue);
    }
    private __newAccount: ObservedPropertyObjectPU<AccountData>;
    get newAccount() {
        return this.__newAccount.get();
    }
    set newAccount(newValue: AccountData) {
        this.__newAccount.set(newValue);
    }
    private __index: ObservedPropertySimplePU<number>;
    get index() {
        return this.__index.get();
    }
    set index(newValue: number) {
        this.__index.set(newValue);
    }
    //post弹窗使用
    private __item: ObservedPropertyObjectPU<AccountData>;
    get item() {
        return this.__item.get();
    }
    set item(newValue: AccountData) {
        this.__item.set(newValue);
    }
    private AccountTable;
    private deleteList: Array<AccountData>;
    private searchController: SearchController;
    private dialogController: CustomDialogController;
    /**
     * post弹窗
     * @param item
     */
    private postDialog: CustomDialogController;
    //list右滑分享
    itemEnd(item: AccountData, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 构建尾端滑出组件
            Image.create({ "id": 16777263, "type": 20000, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
            // 构建尾端滑出组件
            Image.width(34);
            // 构建尾端滑出组件
            Image.height(34);
            // 构建尾端滑出组件
            Image.margin({
                left: 20,
                right: 20,
                bottom: 10,
                top: 10
            });
            // 构建尾端滑出组件
            Image.onClick(() => {
                //日志打印item里的内容
                console.log("日志打印：" + JSON.stringify(item));
                this.item = item;
                this.postDialog.open();
            });
        }, Image);
    }
    accept(isInsert: boolean, newAccount: AccountData): void {
        if (isInsert) {
            Logger.info(`${CommonConstants.INDEX_TAG}`, `The account inserted is:  ${JSON.stringify(newAccount)}`);
            this.AccountTable.insertData(newAccount, (id: number) => {
                newAccount.id = id;
                this.accounts.push(newAccount);
            });
        }
        else {
            this.AccountTable.updateData(newAccount, () => {
            });
            let list = this.accounts;
            this.accounts = [];
            list[this.index] = newAccount;
            this.accounts = list;
            this.index = -1;
        }
    }
    aboutToAppear() {
        this.AccountTable.getRdbStore(() => {
            this.AccountTable.query(0, (result: AccountData[]) => {
                this.accounts = result;
            }, true);
        });
    }
    selectListItem(item: AccountData) {
        this.isInsert = false;
        this.index = this.accounts.indexOf(item);
        this.newAccount = {
            id: item.id,
            accountType: item.accountType,
            typeText: item.typeText,
            amount: item.amount
        };
    }
    deleteListItem() {
        for (let i = 0; i < this.deleteList.length; i++) {
            let index = this.accounts.indexOf(this.deleteList[i]);
            this.accounts.splice(index, 1);
            this.AccountTable.deleteData(this.deleteList[i], () => {
            });
        }
        this.deleteList = [];
        this.isEdit = false;
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create();
            Stack.width(CommonConstants.FULL_WIDTH);
            Stack.height(CommonConstants.FULL_HEIGHT);
            Stack.backgroundColor({ "id": 16777227, "type": 10001, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width(CommonConstants.FULL_WIDTH);
            Column.height(CommonConstants.FULL_HEIGHT);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width(CommonConstants.FULL_WIDTH);
            Row.justifyContent(FlexAlign.SpaceBetween);
            Row.margin({ top: { "id": 16777245, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" }, bottom: { "id": 16777246, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" } });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create({ "id": 16777219, "type": 10003, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
            Text.height({ "id": 16777241, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
            Text.fontSize({ "id": 16777251, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
            Text.margin({ left: { "id": 16777251, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" } });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 0, "type": 30000, params: ['ic_public_edit.svg'], "bundleName": "com.example.rdb", "moduleName": "entry" });
            Image.width({ "id": 16777239, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
            Image.aspectRatio(CommonConstants.FULL_SIZE);
            Image.margin({ right: { "id": 16777251, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" } });
            Image.onClick(() => {
                this.isEdit = true;
            });
        }, Image);
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width(CommonConstants.FULL_WIDTH);
            Row.padding({ left: { "id": 16777245, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" }, right: { "id": 16777245, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" } });
            Row.margin({ top: { "id": 16777249, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" }, bottom: { "id": 16777249, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" } });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Search.create({
                value: this.searchText,
                placeholder: CommonConstants.SEARCH_TEXT,
                controller: this.searchController
            });
            Search.width(CommonConstants.FULL_WIDTH);
            Search.borderRadius({ "id": 16777258, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
            Search.borderWidth({ "id": 16777233, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
            Search.borderColor({ "id": 16777228, "type": 10001, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
            Search.placeholderFont({ size: { "id": 16777252, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" } });
            Search.textFont({ size: { "id": 16777252, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" } });
            Search.backgroundColor(Color.White);
            Search.onChange((searchValue: string) => {
                this.searchText = searchValue;
            });
            Search.onSubmit((searchValue: string) => {
                if (searchValue === '') {
                    this.AccountTable.query(0, (result: AccountData[]) => {
                        this.accounts = result;
                    }, true);
                }
                else {
                    this.AccountTable.query(Number(searchValue), (result: AccountData[]) => {
                        this.accounts = result;
                    }, false);
                }
            });
        }, Search);
        Search.pop();
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width(CommonConstants.FULL_WIDTH);
            Row.padding({ left: { "id": 16777245, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" }, right: { "id": 16777245, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" } });
            Row.margin({ top: { "id": 16777250, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" } });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            List.create({ space: CommonConstants.FULL_SIZE });
            List.width(CommonConstants.FULL_WIDTH);
            List.borderRadius({ "id": 16777257, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
            List.backgroundColor(Color.White);
        }, List);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = (_item, index: number) => {
                const item = _item;
                {
                    const itemCreation = (elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        itemCreation2(elmtId, isInitialRender);
                        if (!isInitialRender) {
                            ListItem.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    };
                    const itemCreation2 = (elmtId, isInitialRender) => {
                        ListItem.create(deepRenderFunction, true);
                        ListItem.width(CommonConstants.FULL_WIDTH);
                        ListItem.height({ "id": 16777235, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
                        ListItem.onClick(() => {
                            this.selectListItem(item);
                            this.dialogController.open();
                        });
                        ListItem.swipeAction({
                            end: {
                                builder: () => {
                                    // this.item = item;
                                    this.itemEnd(item);
                                }
                            }
                        });
                    };
                    const deepRenderFunction = (elmtId, isInitialRender) => {
                        itemCreation(elmtId, isInitialRender);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Row.create();
                            Row.width(CommonConstants.FULL_WIDTH);
                            Row.padding({ left: { "id": 16777245, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" }, right: { "id": 16777245, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" } });
                        }, Row);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Image.create(ImageList[item.typeText]);
                            Image.width({ "id": 16777237, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
                            Image.aspectRatio(CommonConstants.FULL_SIZE);
                            Image.margin({ right: { "id": 16777247, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" } });
                        }, Image);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Text.create(item.typeText);
                            Text.height({ "id": 16777240, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
                            Text.fontSize({ "id": 16777252, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
                        }, Text);
                        Text.pop();
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Blank.create();
                            Blank.layoutWeight(1);
                        }, Blank);
                        Blank.pop();
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            If.create();
                            if (!this.isEdit) {
                                this.ifElseBranchUpdateFunction(0, () => {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        Text.create(item.accountType === 0 ? '-' + item.amount.toString() : '+' + item.amount.toString());
                                        Text.fontSize({ "id": 16777252, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
                                        Text.fontColor(item.accountType === 0 ? { "id": 16777230, "type": 10001, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" } : { "id": 16777229, "type": 10001, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
                                        Text.align(Alignment.End);
                                        Text.flexGrow(CommonConstants.FULL_SIZE);
                                    }, Text);
                                    Text.pop();
                                });
                            }
                            else {
                                this.ifElseBranchUpdateFunction(1, () => {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        Row.create();
                                        Row.align(Alignment.End);
                                        Row.flexGrow(CommonConstants.FULL_SIZE);
                                        Row.justifyContent(FlexAlign.End);
                                    }, Row);
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        Toggle.create({ type: ToggleType.Checkbox });
                                        Toggle.onChange((isOn) => {
                                            if (isOn) {
                                                this.deleteList.push(item);
                                            }
                                            else {
                                                let index = this.deleteList.indexOf(item);
                                                this.deleteList.splice(index, 1);
                                            }
                                        });
                                    }, Toggle);
                                    Toggle.pop();
                                    Row.pop();
                                });
                            }
                        }, If);
                        If.pop();
                        Row.pop();
                        ListItem.pop();
                    };
                    this.observeComponentCreation2(itemCreation2, ListItem);
                    ListItem.pop();
                }
            };
            this.forEachUpdateFunction(elmtId, this.accounts, forEachItemGenFunction, undefined, true, false);
        }, ForEach);
        ForEach.pop();
        List.pop();
        Row.pop();
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (!this.isEdit) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Button.createWithChild();
                        Button.width({ "id": 16777238, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
                        Button.height({ "id": 16777238, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
                        Button.position({ x: CommonConstants.EDIT_POSITION_X, y: CommonConstants.EDIT_POSITION_Y });
                        Button.onClick(() => {
                            this.isInsert = true;
                            this.newAccount = {
                                id: 0,
                                accountType: 0,
                                typeText: '',
                                amount: 0
                            };
                            this.dialogController.open();
                        });
                    }, Button);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Image.create({ "id": 0, "type": 30000, params: ['add.png'], "bundleName": "com.example.rdb", "moduleName": "entry" });
                    }, Image);
                    Button.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
        }, If);
        If.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.isEdit) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Button.createWithChild();
                        Button.width({ "id": 16777238, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
                        Button.height({ "id": 16777238, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
                        Button.backgroundColor({ "id": 16777227, "type": 10001, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" });
                        Button.markAnchor({ x: { "id": 16777256, "type": 10002, params: [], "bundleName": "com.example.rdb", "moduleName": "entry" }, y: CommonConstants.MINIMUM_SIZE });
                        Button.position({ x: CommonConstants.DELETE_POSITION_X, y: CommonConstants.DELETE_POSITION_Y });
                        Button.onClick(() => {
                            this.deleteListItem();
                        });
                    }, Button);
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Image.create({ "id": 0, "type": 30000, params: ['delete.png'], "bundleName": "com.example.rdb", "moduleName": "entry" });
                    }, Image);
                    Button.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
        }, If);
        If.pop();
        Stack.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName(): string {
        return "MainPage";
    }
}
registerNamedRoute(() => new MainPage(undefined, {}), "", { bundleName: "com.example.rdb", moduleName: "entry", pagePath: "pages/MainPage", pageFullPath: "entry/src/main/ets/pages/MainPage", integratedHsp: "false", moduleType: "followWithHap" });
