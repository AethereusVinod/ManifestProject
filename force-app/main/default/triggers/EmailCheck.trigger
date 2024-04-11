trigger EmailCheck on Contact (before insert, before update) {
    for(contact con : trigger.new){
        if(con.Email==null){
            if(trigger.isInsert){
                con.addError('Email ID field should not be empty');
            }
            if(trigger.isUpdate){
                con.addError('Email ID field should not be empty in Update');
            }
        }
    }
}
/*
for(contact con : trigger.new)
    if(trigger.isInsert && con.Email == null){
        con.addError('Email ID field should not be empty');
    }

    if(trigger.isDelete && con.Email == null){
        con.addError('Email ID field should not be empty in Update');
    }
*/