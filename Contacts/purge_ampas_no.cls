// set variables
// Initial Dataset = 749 records
boolean goForPurge = true;
Integer runSize = 250;

Contact [] contactsToUpdate = 
  [
    SELECT Id,
      AMPAS_Employee__c,
      AMPAS_No__c,
      FirstName,
      LastName
    FROM Contact
    WHERE RecordType.Name != 'SIS Employee'
      AND AMPAS_No__c != '' 
      LIMIT :runSize 
  ];

  System.assert(contactsToUpdate.size() > 0, 'No Records To Update');
    for(Integer r = 0; r < contactsToUpdate.size(); r++) {
  		System.System.debug('contactsToUpdate: ' + r + ' ' +
          contactsToUpdate[r].AMPAS_No__c + ' ' +
          contactsToUpdate[r].LastName);
    }


  if (goForPurge) {
    for(Integer i = 0; i < contactsToUpdate.size(); i++) {
      contactsToUpdate[i].AMPAS_No__c = '';
    }

    update contactsToUpdate;
  }
