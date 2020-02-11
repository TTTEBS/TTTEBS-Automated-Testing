page 50140 "MyTestsExecutor"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'My Test Executor';

    actions
    {
        area(Processing)
        {
            action(MyFirstTestCodeunit)
            {
                Caption = 'Test01 Codeunit';
                ToolTip = 'Executes Test01 Codeunit';
                ApplicationArea = All;
                Image = ExecuteBatch;
                RunObject = codeunit Test01;
            }
            action(MySecondTestCodeunit)
            {
                Caption = 'Test02 Codeunit';
                ToolTip = 'Executes Test02 Codeunit';
                ApplicationArea = All;
                Image = ExecuteBatch;
                RunObject = codeunit Test02;
            }
            action(MyThirdTestCodeunit)
            {
                Caption = 'Test03 Codeunit';
                ToolTip = 'Executes Test03 Codeunit';
                ApplicationArea = All;
                Image = ExecuteBatch;
                RunObject = codeunit Test03;
            }
            action(MyFourthTestCodeunit)
            {
                Caption = 'Test04 Codeunit';
                ToolTip = 'Executes Test04 Codeunit';
                ApplicationArea = All;
                Image = ExecuteBatch;
                RunObject = codeunit Test04;
            }
        }
    }
}