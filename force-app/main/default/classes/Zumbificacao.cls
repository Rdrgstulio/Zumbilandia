public class Zumbificacao 
{
    @InvocableMethod (label='Transform Zumbie')
    public static void changeTypeZombie(List<id> ids)
    {
        List<Creature__C> criList = [SELECT id, Bunker__r.name, Bunker__c, (SELECT id from Creature__r) FROM Creature__c WHERE id in :ids];
		list<ResourcesofCreature__c> rcDeleteList = new List<ResourcesofCreature__c>();
		for ( Creature__c cr : crilist){
            String TypeZombie = '';
            Integer rand = Math.mod(Integer.valueOf(Math.random()*1000),100);
            if(rand < 50)
            {
                TypeZombie = 'Slow';
            }
            else if (rand < 80){
                TypeZombie = 'Fat';                                   
            }
            else{
                TypeZombie = 'Fast';
            }
            cr.TypeZombie__c = TypeZombie;
            if(cr.Creature__r != null)
            	rcDeleteList.addAll(cr.Creature__r);
        }    
           update criList;
           delete rcDeleteList;
    }
}