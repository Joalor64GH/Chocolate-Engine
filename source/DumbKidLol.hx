package;

class DumbKidLol extends RealDumbass
{
    var bitches:Int = 1;
    var family:Bool = true;
    var gotalife:Bool = true;
    var adopted:Bool = false;
    var STUPID:Bool = false;
    var ratio(default, set):Int;
    var hasBrain:Bool = true;
    var stupidKid:String = 'NimuDevUwU';

    function set_ratio(r:Int):Int
    {
        if (stupidKid == 'NimuDevUwU'){
            return 9999;
        }
        else if (stupidKid == 'MemeHoovy'){
            return 0;
        }
        else {
            return ratio = r;
        }
    }

    override function create()
    {
        if (stupidKid == 'NimuDevUwU') 
        {
            bitches = 0;
            family = false;
            gotalife = false;
            adopted = true;
            STUPID = true;
            // ratio++;
            hasBrain = false;
        }
    }
}
//you know i had to do it to em