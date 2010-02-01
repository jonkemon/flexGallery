package com.unitedmindset.models
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    [Event(name="searchListChanged",type="flash.events.Event")]
    
    public class SampleModel extends EventDispatcher
    {
        public static const SEARCH_LIST_CHANGED:String = "searchListChanged";
        
        public function SampleModel(target:IEventDispatcher=null)
        {
            super(target);
        }
        
        private var _searchList:Array;

        public function get searchList():Array
        {
            return _searchList;
        }

        public function set searchList(v:Array):void
        {
            _searchList = v;
            dispatchEvent(new Event(SEARCH_LIST_CHANGED));
        }

        
    }
}