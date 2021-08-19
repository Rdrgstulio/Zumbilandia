global class ContagionSchedulable implements Schedulable 
{
    global void execute(SchedulableContext SC){
        
      this.contagiar(); 
    }
    
    private void contagiar(){
        
        List<Creature__c> humanList = [SELECT id, bunker__r.DefenseBunker__c, bunker__c, (select id, AddedDefense__c  from Creature__r) FROM Creature__c  where recordtypeId ='0125e000000iMFzAAM'];
        List<Creature__c> zombieList = [SELECT id FROM Creature__c where recordtypeId = '0125e000000iMG9AAM'];
        
        for(Creature__c zb : zombieList){
            if(humanList.size() ==0) break;
            Creature__c hmn1 = humanList.get(Math.mod(Integer.valueOf(Math.random()*1000), humanList.size()));
            Decimal defesa = 0;
            if(hmn1.recordtypeId  != '0125e000000iMG9AAM')
            {
                if(hmn1.bunker__c != null)
                {
                    defesa += hmn1.bunker__r.DefenseBunker__c;
                }
                if(hmn1.Creature__r != null)
                {
                    for(ResourcesofCreature__c recCri : hmn1.Creature__r)
                    {
                        defesa += recCri.AddedDefense__c;
                    }
                }
            }
            Integer DiceRoll = Math.mod(Integer.valueof(Math.random()*100000),100)+1;
            if(DiceRoll > defesa)
            {
                hmn1.recordtypeId  = '0125e000000iMG9AAM';
                hmn1.DatadaZumbificao__c = Date.today();
            }
            defesa = 0;
            Creature__c hmn2 = humanList.get(Math.mod(Integer.valueof(Math.random()*1000),humanList.size()));
            if(hmn2.recordtypeId  != '0125e000000iMG9AAM')
            {
                if(hmn2.bunker__c != null)
                {
                    defesa += hmn2.bunker__r.DefenseBunker__c;
                }
                if(hmn2.Creature__r != null)
                {
                    for(ResourcesofCreature__c recCri : hmn2.Creature__r)
                    {
                        defesa += recCri.AddedDefense__c;
                    }
                }
            }
            Integer DiceRoll2 = Math.mod(Integer.valueof(Math.random()*100000),100)+1;
            if(DiceRoll2 > defesa)
            {
                hmn2.recordtypeId  = '0125e000000iMG9AAM';
                hmn2.DatadaZumbificao__c = Date.today();
            }
        }
        update humanList;
    }

}