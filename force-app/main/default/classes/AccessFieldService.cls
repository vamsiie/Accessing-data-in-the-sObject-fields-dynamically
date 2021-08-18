public class AccessFieldService {
	
	public static Object getFieldValue(SObject sObjectRecord, String fieldpPath) {
		try {
			SObject tempRecord = sObjectRecord;
			List<String> fieldSplit = fieldpPath.split('\\.');

			while(fieldSplit.size() > 1) {
				tempRecord = sObjectRecord.getSObject(fieldSplit.remove(0));
			}

			return tempRecord.get(fieldSplit[0]);
		} catch(Exception e) {
			return null;
		}
		
	}

	public static void getSObjectsData(String sObjectName, List<String> fields, string whereCOndition) {

		String queryFields = String.join(fields, ',');
		String query = 'SELECT ' + queryFields + ' FROM ' + sObjectName + ' ' + whereCOndition;
		List<SObject> sObjectRecords = Database.query(query);

		for(SObject record : sObjectRecords) {
			for(String field : fields) {
                //Using the below code we can get the field values dynamically.
				System.debug('Field Name : ' + field + '; Field Value :  ' + getFieldValue(record, field));
			}
		}

	}

}
