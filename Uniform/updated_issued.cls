// Varialbes to set
boolean goForUpdate = false;
Integer runSize = 10;
datetime returnDateTime = datetime.now();

Uniform_issuance__c [] issuedUniforms = 
  [
    SELECT 
      Id, 
      Item_Returned__c,
      Format(LastModifiedDate), 
      Location_Data__r.Name, 
      Name, 
      Qty_Issued_Removed_From_Stock__c, 
      Qty_Returned_Added_To_Stock__c,
      Returned_Date_and_Time__c,
      Transaction_Status__c, 
      Transaction_Type__c, 
      Uniform_Balance__c, 
      Uniform_Number__r.Name
    FROM Uniform_Issuance__c
    WHERE Location_Data__r.Name = '59800 - AMPAS Master'
      AND Uniform_Balance__c = -1
      AND Uniform_Number__r.Retired_Item__c = false
    ORDER BY Uniform_Number__c
    LIMIT :runSize
  ];

  System.assert(issuedUniforms.size() > 0, 'No records to return');

  for (Integer i = 0; i < issuedUniforms.size(); i++) {
    System.debug(i + ': Issued Uniform ' + issuedUniforms[i].Name);
  }

  if (goForUpdate) {
    for (Integer r = 0; r < issuedUniforms.size(); r++) {
      issuedUniforms[r].Qty_Returned_Added_To_Stock__c = 1;
      issuedUniforms[r].Item_Returned__c = true;
      issuedUniforms[r].Returned_Date_and_Time__c = returnDateTime;
    }

    update issuedUniforms;
  }