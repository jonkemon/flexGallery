package com.telecoms.media.flexGallery.controller
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.rpc.http.HTTPService;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.events.FlexEvent;

	public class Controllers
	{
		
		[Bindable]
        public var view:UMBlogMVC;
        
        private var _model:SampleModel;
	        
        public function SampleController()
        {
            _model = new SampleModel();
            _model.addEventListener(SampleModel.SEARCH_LIST_CHANGED,_onSearchListChanged);
        }

		
		public function flexGallery_creationCompleteHandler():void
        {
            runSearch();
        }

        public function runSearch(event:MouseEvent=null):void
        {
            var service:HTTPService = new HTTPService();
            service.addEventListener(ResultEvent.RESULT,_httpService_resultHandler);
            service.addEventListener(FaultEvent.FAULT,_httpService_faultHandler);
            service.resultFormat = "e4x";
            service.url = "http://www.someUrl.com/yourMethod";
            service.send({searchTerm:view.searchInput.text});
        }


        private function _httpService_resultHandler(event:ResultEvent):void
        {
            var service:HTTPService = event.target as HTTPService;
            service.removeEventListener(ResultEvent.RESULT,_httpService_resultHandler);
            service.removeEventListener(FaultEvent.FAULT,_httpService_faultHandler);
            _model.searchList = event.result as Array;
        }


        private function _httpService_faultHandler(event:FaultEvent):void
        {
            var service:HTTPService = event.target as HTTPService;
            service.removeEventListener(ResultEvent.RESULT,_httpService_resultHandler);
            service.removeEventListener(FaultEvent.FAULT,_httpService_faultHandler);
            _model.searchList = new Array();
            Alert.show("fault");
        }

	}
}