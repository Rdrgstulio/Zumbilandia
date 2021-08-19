trigger CreatureTrigger on Creature__c (before insert, after insert) 
{
    for(creature__c cr: trigger.new)
		system.debug('Funciona');
}