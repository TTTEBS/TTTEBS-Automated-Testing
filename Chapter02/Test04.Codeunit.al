codeunit 50143 "Test04"
{
    Subtype = Test;

    // TTTEBS >>
    [Test]
    procedure TestFunction3()
    var
        ItemCard: TestPage "Item Card";
    begin
        ItemCard.OpenView();
        ItemCard.First();
        ItemCard."No.".AssertEquals('1896-S');
        ItemCard.Close();
    end;
    // TTTEBS <<

    [Test]
    procedure TestFunction1()
    var
        PaymentTerms: TestPage "Payment Terms";
    begin
        PaymentTerms.OpenView();
        PaymentTerms.Last();
        PaymentTerms.Code.AssertEquals('LUC');
        PaymentTerms.Close();
    end;

    [Test]
    procedure TestFunction2()
    var
        PaymentTerms: TestPage "Payment Terms";
    begin
        PaymentTerms.OpenNew();
        PaymentTerms.Code.SetValue('LUC');
        PaymentTerms."Discount %".SetValue('56');
        PaymentTerms.Description.SetValue(
                PaymentTerms.Code.Value()
            );
        ERROR('Code: %1 \Discount %: %2 \Description: %3',
                PaymentTerms.Code.Value(),
                PaymentTerms."Discount %".Value(),
                PaymentTerms.Description.Value()
            );
        PaymentTerms.Close();
    end;
}