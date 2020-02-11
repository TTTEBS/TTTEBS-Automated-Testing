codeunit 50144 "LookupValue UT Customer"
{
    Subtype = Test;

    //[FEATURE] LookupValue UT Customer

    var
        Assert: Codeunit Assert;
        LibraryUtility: Codeunit "Library - Utility";
        LibrarySales: Codeunit "Library - Sales";

    [Test]  //[SCENARIO #0001] Assign lookup value to customer
    procedure AssignLookupValueToCustomer()
    var
        lr_Cust: Record Customer;
        lv_LookupValueCode: Code[10];
    begin
        //[GIVEN] A lookup value
        lv_LookupValueCode := CreateLookupValueCode();
        //[GIVEN] A customer
        CreateCustomer(lr_Cust);
        //[WHEN] Set lookup value on customer
        SetLookupValueOnCustomer(lr_Cust, lv_LookupValueCode);
        //[THEN] Customer has lookup value code field populated
        VerifyLookupValueOnCustomer(lr_Cust."No.", lv_LookupValueCode);
        // VerifyLookupValueOnCustomer(lr_Cust."No.", 'xxx');  // TTTEBS - Test error!
    end;

    [Test]  //[SCENARIO #0002] Assign non-existing lookup value to customer
    procedure AssignNonExistingLookupValueToCustomer()
    //[FEATURE] LookupValue UT Customer
    var
        lr_Cust: Record Customer;
        lv_LookupValueCode: Code[10];
    begin
        //[GIVEN] A non-existing lookup value
        lv_LookupValueCode := 'SC #0002';
        //[GIVEN] A customer record variable
        // See local variable Customer -> TTTEBS Already created in first test!
        //[WHEN] Set non-existing lookup value on customer
        asserterror SetLookupValueOnCustomer(lr_Cust, lv_LookupValueCode);
        //[THEN] Non existing lookup value error thrown
        VerifyNonExistingLookupValueError(lv_LookupValueCode);
        // VerifyNonExistingLookupValueError('xxx');
    end;

    [Test]  //[SCENARIO #0003] Assign lookup value on customer card (TTTEBS - Close to #0001)
    [HandlerFunctions('HandleConfigTemplates')]
    procedure AssignLookupValueToCustomerCard()
    var
        ltp_CustomerCard: TestPage "Customer Card";
        lv_CustNo: Code[20];
        lv_LookupValueCode: Code[10];
    begin
        //[GIVEN] A lookup value
        lv_LookupValueCode := CreateLookupValueCode();
        //[GIVEN] A customer card
        CreateCustomerCard(ltp_CustomerCard);
        //[WHEN] Set lookup value on customer card
        lv_CustNo := SetLookupValueOnCustomerCard(ltp_CustomerCard, lv_LookupValueCode);
        //[THEN] Customer has lookup value field populated
        VerifyLookupValueOnCustomer(lv_CustNo, lv_LookupValueCode);
    end;

    local procedure CreateLookupValueCode(): Code[10]
    var
        lr_LookupValue: Record LookupValue;
        lc_LibraryUtility: Codeunit "Library UT Utility";  // TTTEBS
    begin
        with lr_LookupValue do begin
            Init();
            Validate(Code, lc_LibraryUtility.GetNewCode10());  // TTTEBS
            Validate(Description, Code);
            Insert();
            exit(Code);
        end;
    end;

    local procedure CreateCustomer(var Customer: record Customer)
    begin
        LibrarySales.CreateCustomer(Customer);
    end;

    local procedure SetLookupValueOnCustomer(var Customer: record Customer; LookupValueCode: Code[10])
    begin
        with Customer do begin
            Validate("Lookup Value Code", LookupValueCode);
            Modify();
        end;
    end;

    local procedure VerifyLookupValueOnCustomer(CustomerNo: Code[20]; LookupValueCode: Code[10])
    var
        lr_Cust: Record Customer;
        lv_FieldOnTableTxt: Label '%1 on %2';
    begin
        with lr_Cust do begin
            Get(CustomerNo);
            Assert.AreEqual(
                LookupValueCode,
                "Lookup Value Code",
                StrSubstNo(
                    lv_FieldOnTableTxt,
                    FieldCaption("Lookup Value Code"),
                    TableCaption())
                );
        end;
    end;

    local procedure VerifyNonExistingLookupValueError(LookupValueCode: Code[10])
    var
        lr_Cust: Record Customer;
        lr_LookupValue: Record LookupValue;
        lv_ValueCannotBeFoundInTableTxt: Label 'The field %1 of table %2 contains a value (%3) that cannot be found in the related table (%4).';
    begin
        with lr_Cust do
            Assert.ExpectedError(
                StrSubstNo(
                    lv_ValueCannotBeFoundInTableTxt,
                    FieldCaption("Lookup Value Code"),
                    TableCaption(),
                    LookupValueCode,
                    lr_LookupValue.TableCaption()));
    end;

    local procedure CreateCustomerCard(var CustomerCard: TestPage "Customer Card")
    begin
        CustomerCard.OpenNew();
    end;

    local procedure SetLookupValueOnCustomerCard(var CustomerCard: TestPage "Customer Card"; LookupValueCode: Code[10]) pv_CustNo: Code[20]
    begin
        with CustomerCard do begin
            Assert.IsTrue("Lookup Value Code".Editable(), 'Editable');
            // Assert.IsFalse("Lookup Value Code".Editable(), 'Editable');  // TTTEBS - Test error..
            "Lookup Value Code".SetValue(LookupValueCode);
            pv_CustNo := "No.".Value();
            Close();
        end;
    end;

    [ModalPageHandler]
    procedure HandleConfigTemplates(var ConfigTemplates: TestPage "Config Templates")
    begin
        ConfigTemplates.OK.Invoke();
    end;
}