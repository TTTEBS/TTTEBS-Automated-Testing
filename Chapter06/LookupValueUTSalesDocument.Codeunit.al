codeunit 50150 "LookupValue UT Sales Document"
{
    Subtype = Test;

    // [FEATURE] LookupValue UT Sales Document
    // Instruction NOTES
    // (1) Replacing the argument LookupValueCode in verification call, i.e. [THEN] clause, should make any test fail
    // (2) Making field "Lookup Value Code", on any of the related pages, Visible=false should make any UI test fail

    var
        Assert: Codeunit Assert;
        LibraryUtility: Codeunit "Library - Utility";
        LibrarySales: Codeunit "Library - Sales";
        isInitialized: Boolean;
        LookupValueCode: Code[10];

    [Test]  //[SCENARIO #0004] Assign lookup value to sales header
    procedure AssignLookupValueToSalesHeader()
    var
        lr_SH: Record "Sales Header";
    begin
        Initialize();
        //[GIVEN] A lookup value
        //[GIVEN] A sales header
        CreateSalesHeader(lr_SH);
        //[WHEN] Set lookup value on sales header
        SetLookupValueOnSalesHeader(lr_SH, LookupValueCode);
        //[THEN] Sales header has lookup value code field populated
        VerifyLookupValueOnSalesHeader(lr_SH."Document Type", lr_SH."No.", LookupValueCode);
    end;

    [Test]  //[SCENARIO #0005] Assign non-existing lookup value on sales header
    procedure AssignNonExistingLookupValueToSalesHeader()
    var
        lr_SH: Record "Sales Header";
        lv_NonExistingLookupValueCode: Code[10];
    begin
        //[GIVEN] A non-existing lookup value
        lv_NonExistingLookupValueCode := 'SC #0005';
        //[GIVEN] A sales header record variable
        // See local variable SalesHeader

        //[WHEN] Set non-existing lookup value to sales header
        asserterror SetLookupValueOnSalesHeader(lr_SH, lv_NonExistingLookupValueCode);

        //[THEN] Non existing lookup value error was thrown
        VerifyNonExistingLookupValueError(lv_NonExistingLookupValueCode);
    end;

    [Test]  //[SCENARIO #0006] Assign lookup value on sales quote document page
    procedure AssignLookupValueToSalesQuoteDocument()
    var
        lr_SH: Record "Sales Header";
        ltp_SalesDocument: TestPage "Sales Quote";
        DocumentNo: Code[20];
    begin
        //[GIVEN] A lookup value
        Initialize();
        //[GIVEN] A sales quote document page
        CreateSalesQuoteDocument(ltp_SalesDocument);
        //[WHEN] Set lookup value on sales quote document
        DocumentNo := SetLookupValueOnSalesQuoteDocument(ltp_SalesDocument, LookupValueCode);
        //[THEN] Sales quote has lookup value code field populated
        VerifyLookupValueOnSalesHeader(lr_SH."Document Type"::Quote, DocumentNo, LookupValueCode);
    end;

    [Test]  //[SCENARIO #0007] Assign lookup value on sales order document page
    procedure AssignLookupValueToSalesOrderDocument()
    var
        lr_SH: Record "Sales Header";
        ltp_SalesDocument: TestPage "Sales Order";
        lv_DocNo: Code[20];
    begin
        //[GIVEN] A lookup value
        Initialize();
        //[GIVEN] A sales order document page
        CreateSalesOrderDocument(ltp_SalesDocument);
        //[WHEN] Set lookup value on sales order document
        lv_DocNo := SetLookupValueOnSalesOrderDocument(ltp_SalesDocument, LookupValueCode);
        //[THEN] Sales order has lookup value code field populated
        VerifyLookupValueOnSalesHeader(lr_SH."Document Type"::Order, lv_DocNo, LookupValueCode);
    end;

    [Test]  //[SCENARIO #0008] Assign lookup value on sales invoice document page
    procedure AssignLookupValueToSalesInvoiceDocument()
    var
        lr_SH: Record "Sales Header";
        ltp_SalesDocument: TestPage "Sales Invoice";
        lv_DocNo: Code[20];
    begin
        //[GIVEN] A lookup value
        Initialize();
        //[GIVEN] A sales invoice document page
        CreateSalesInvoiceDocument(ltp_SalesDocument);
        //[WHEN] Set lookup value on sales invoice document
        lv_DocNo := SetLookupValueOnSalesInvoiceDocument(ltp_SalesDocument, LookupValueCode);
        //[THEN] Sales invoice has lookup value code field populated
        VerifyLookupValueOnSalesHeader(lr_SH."Document Type"::Invoice, lv_DocNo, LookupValueCode);
    end;

    [Test]  //[SCENARIO #0009] Assign lookup value on sales credit memo document page
    procedure AssignLookupValueToSalesCreditMemoDocument()
    var
        lr_SH: Record "Sales Header";
        ltp_SalesDocument: TestPage "Sales Credit Memo";
        lv_DocNo: Code[20];
    begin
        //[GIVEN] A lookup value
        Initialize();
        //[GIVEN] A sales credit memo document page
        CreateSalesCreditMemoDocument(ltp_SalesDocument);
        //[WHEN] Set lookup value on sales credit memo document
        lv_DocNo := SetLookupValueOnSalesCreditMemoDocument(ltp_SalesDocument, LookupValueCode);
        //[THEN] Sales credit memo has lookup value code field populated
        VerifyLookupValueOnSalesHeader(lr_SH."Document Type"::"Credit Memo", lv_DocNo, LookupValueCode);
    end;

    [Test]  //[SCENARIO #0010] Assign lookup value on sales return order document page
    procedure AssignLookupValueToSalesReturnOrderDocument()
    var
        lr_SH: Record "Sales Header";
        ltp_SalesDocument: TestPage "Sales Return Order";
        lv_DocNo: Code[20];
    begin
        //[GIVEN] A lookup value
        Initialize();
        //[GIVEN] A sales return order document page
        CreateSalesReturnOrderDocument(ltp_SalesDocument);
        //[WHEN] Set lookup value on sales return order document
        lv_DocNo := SetLookupValueOnSalesReturnOrderDocument(ltp_SalesDocument, LookupValueCode);
        //[THEN] Sales return order has lookup value code field populated
        VerifyLookupValueOnSalesHeader(lr_SH."Document Type"::"Return Order", lv_DocNo, LookupValueCode);
    end;

    [Test]  //[SCENARIO #0011] Assign lookup value on blanket sales order document page
    procedure AssignLookupValueToBlanketSalesOrderDocument()
    var
        lr_SH: Record "Sales Header";
        ltp_SalesDocument: TestPage "Blanket Sales Order";
        lv_DocNo: Code[20];
    begin
        //[GIVEN] A lookup value
        Initialize();
        //[GIVEN] A blanket sales order document page
        CreateBlanketSalesOrderDocument(ltp_SalesDocument);
        //[WHEN] Set lookup value on blanket sales order document
        lv_DocNo := SetLookupValueOnBlanketSalesOrderDocument(ltp_SalesDocument, LookupValueCode);
        //[THEN] Blanket sales order has lookup value code field populated
        VerifyLookupValueOnSalesHeader(lr_SH."Document Type"::"Blanket Order", lv_DocNo, LookupValueCode);
    end;

    local procedure Initialize()
    begin
        if isInitialized then
            exit;
        LookupValueCode := CreateLookupValueCode();
        isInitialized := true;
        Commit();
    end;

    local procedure CreateLookupValueCode(): Code[10]
    var
        LookupValue: Record LookupValue;
    begin
        with LookupValue do begin
            Init();
            Validate(
                Code,
                LibraryUtility.GenerateRandomCode(FIELDNO(Code),
                Database::LookupValue));
            Validate(Description, Code);
            Insert();
            exit(Code);
        end;
    end;

    local procedure CreateSalesHeader(var SalesHeader: record "Sales Header")
    begin
        LibrarySales.CreateSalesHeader(SalesHeader, SalesHeader."Document Type"::Invoice, '');
    end;

    local procedure SetLookupValueOnSalesHeader(var SalesHeader: record "Sales Header"; LookupValueCode: Code[10])
    begin
        with SalesHeader do begin
            Validate("Lookup Value Code", LookupValueCode);
            Modify();
        end;
    end;

    local procedure CreateSalesQuoteDocument(var SalesDocument: TestPage "Sales Quote")
    begin
        SalesDocument.OpenNew();
    end;

    local procedure SetLookupValueOnSalesQuoteDocument(var SalesDocument: TestPage "Sales Quote"; LookupValueCode: Code[10]) DocumentNo: Code[20]
    begin
        with SalesDocument do begin
            Assert.IsTrue("Lookup Value Code".Editable(), 'Editable');
            "Lookup Value Code".SetValue(LookupValueCode);
            DocumentNo := "No.".Value();
            Close();
        end;
    end;

    local procedure CreateSalesOrderDocument(var SalesDocument: TestPage "Sales Order")
    begin
        SalesDocument.OpenNew();
    end;

    local procedure SetLookupValueOnSalesOrderDocument(var SalesDocument: TestPage "Sales Order"; LookupValueCode: Code[10]) DocumentNo: Code[20]
    begin
        with SalesDocument do begin
            Assert.IsTrue("Lookup Value Code".Editable(), 'Editable');
            "Lookup Value Code".SetValue(LookupValueCode);
            DocumentNo := "No.".Value();
            Close();
        end;
    end;

    local procedure CreateSalesInvoiceDocument(var SalesDocument: TestPage "Sales Invoice")
    begin
        SalesDocument.OpenNew();
    end;

    local procedure SetLookupValueOnSalesInvoiceDocument(var SalesDocument: TestPage "Sales Invoice"; LookupValueCode: Code[10]) DocumentNo: Code[20]
    begin
        with SalesDocument do begin
            Assert.IsTrue("Lookup Value Code".Editable(), 'Editable');
            "Lookup Value Code".SetValue(LookupValueCode);
            DocumentNo := "No.".Value();
            Close();
        end;
    end;

    local procedure CreateSalesCreditMemoDocument(var SalesDocument: TestPage "Sales Credit Memo")
    begin
        SalesDocument.OpenNew();
    end;

    local procedure SetLookupValueOnSalesCreditMemoDocument(var SalesDocument: TestPage "Sales Credit Memo"; LookupValueCode: Code[10]) DocumentNo: Code[20]
    begin
        with SalesDocument do begin
            Assert.IsTrue("Lookup Value Code".Editable(), 'Editable');
            "Lookup Value Code".SetValue(LookupValueCode);
            DocumentNo := "No.".Value();
            Close();
        end;
    end;

    local procedure CreateSalesReturnOrderDocument(var SalesDocument: TestPage "Sales Return Order")
    begin
        SalesDocument.OpenNew();
    end;

    local procedure SetLookupValueOnSalesReturnOrderDocument(var SalesDocument: TestPage "Sales Return Order"; LookupValueCode: Code[10]) DocumentNo: Code[20]
    begin
        with SalesDocument do begin
            Assert.IsTrue("Lookup Value Code".Editable(), 'Editable');
            "Lookup Value Code".SetValue(LookupValueCode);
            DocumentNo := "No.".Value();
            Close();
        end;
    end;

    local procedure CreateBlanketSalesOrderDocument(var SalesDocument: TestPage "Blanket Sales Order")
    begin
        SalesDocument.OpenNew();
    end;

    local procedure SetLookupValueOnBlanketSalesOrderDocument(var SalesDocument: TestPage "Blanket Sales Order"; LookupValueCode: Code[10]) DocumentNo: Code[20]
    begin
        with SalesDocument do begin
            Assert.IsTrue("Lookup Value Code".Editable(), 'Editable');
            "Lookup Value Code".SetValue(LookupValueCode);
            DocumentNo := "No.".Value();
            Close();
        end;
    end;

    local procedure VerifyLookupValueOnSalesHeader(DocumentType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order"; DocumentNo: Code[20]; LookupValueCode: Code[10])
    var
        SalesHeader: Record "Sales Header";
        FieldOnTableTxt: Label '%1 on %2';
    begin
        with SalesHeader do begin
            Get(DocumentType, DocumentNo);
            Assert.AreEqual(
                LookupValueCode,
                "Lookup Value Code",
                StrSubstNo(
                    FieldOnTableTxt,
                    FieldCaption("Lookup Value Code"),
                    TableCaption())
                );
        end;
    end;

    local procedure VerifyNonExistingLookupValueError(LookupValueCode: Code[10])
    var
        SalesHeader: Record "Sales Header";
        LookupValue: Record LookupValue;
        ValueCannotBeFoundInTableTxt: Label 'The field %1 of table %2 contains a value (%3) that cannot be found in the related table (%4).';
    begin
        with SalesHeader do
            Assert.ExpectedError(
                StrSubstNo(
                    ValueCannotBeFoundInTableTxt,
                    FieldCaption("Lookup Value Code"),
                    TableCaption(),
                    LookupValueCode,
                    LookupValue.TableCaption()));
    end;
}