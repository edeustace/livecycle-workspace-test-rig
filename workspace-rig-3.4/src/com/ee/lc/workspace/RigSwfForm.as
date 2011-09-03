
package com.ee.lc.workspace
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.DataEvent;
	import flash.events.Event;
	import lc.procmgmt.events.FormEvents;
	import lc.procmgmt.events.SwfAppButtonEvent;
	
	import mx.controls.SWFLoader;
	
	[Event(name = "formReady", type = "flash.events.Event")]
	[Event(name = "formSubmitData", type = "flash.events.DataEvent")]
	[Event(name = "formSaveData", type = "flash.events.DataEvent")]
	public class RigSwfForm extends SWFLoader
	{
		private var _formLoaderInfo:LoaderInfo;
		
		private var _valid:Boolean;
		
		private var _clean:Boolean;
		
		[Bindable]
		public var showRouteButtons:Boolean = true;
		
		[Bindable]
		public var showSaveButton:Boolean = true;
		
		[Bindable]
		public function get valid():Boolean
		{
			return _valid;
		}
		
		public function set valid(isValid:Boolean):void
		{
			_valid = isValid;
		}
		
		[Bindable]
		public function get clean():Boolean
		{
			return _clean;
		}
		
		/** @private */
		public function set clean(isClean:Boolean):void
		{
			_clean = isClean;
		}
		
		public function RigSwfForm()
		{
			super();
			addEventListener(Event.INIT, onInit);
			addEventListener(Event.COMPLETE, onComplete);
		}
		
		override public function load(url:Object = null):void
		{
			super.load(url);
		}
		
		public function setInitalData(inputXml:String):void
		{
			trace("Workspace -->> Form: " + FormEvents.FORM_INITIAL_DATA);
			var dataEvent:DataEvent = new DataEvent(FormEvents.FORM_INITIAL_DATA, false, false, inputXml);
			_formLoaderInfo.sharedEvents.dispatchEvent(dataEvent);
		}
		
		public function submitWithSelectedRoute(value:String):void
		{
			trace("Workspace -->> Form: " + FormEvents.FORM_SUBMIT_DATA_REQUEST + " with route: " + value);
			var dataEvent:DataEvent = new DataEvent(FormEvents.FORM_SUBMIT_DATA_REQUEST, false, false, value);
			_formLoaderInfo.sharedEvents.dispatchEvent(dataEvent);
		}
		
		public function submit():void
		{
			trace("Workspace -->> Form: " + FormEvents.FORM_SUBMIT_DATA_REQUEST);
			var dataEvent:DataEvent = new DataEvent(FormEvents.FORM_SUBMIT_DATA_REQUEST, false, false);
			_formLoaderInfo.sharedEvents.dispatchEvent(dataEvent);
		}
		
		public function save():void
		{
			var dataEvent:DataEvent = new DataEvent(FormEvents.FORM_SAVE_DATA_REQUEST, false, false);
			trace("Workspace -->> Form: " + dataEvent.type);
			_formLoaderInfo.sharedEvents.dispatchEvent(dataEvent);
		}
		
		protected function onEventFromSwf(event:Event):void
		{
			trace("Workspace <<-- Form: " + event.type);
			dispatchEvent(event.clone());
		}
		
		private function onComplete(event:Event):void
		{
		}
		
		private function onInit(event:Event):void
		{
			initForm();
		}
		
		private function initForm():void
		{
			if (_formLoaderInfo == null)
			{
				_formLoaderInfo = Loader(getChildAt(0)).contentLoaderInfo;
				_formLoaderInfo.sharedEvents.addEventListener(FormEvents.FORM_READY, onEventFromSwf);
				_formLoaderInfo.sharedEvents.addEventListener(FormEvents.FORM_SUBMIT_DATA, onEventFromSwf);
				_formLoaderInfo.sharedEvents.addEventListener(FormEvents.FORM_SAVE_DATA, onEventFromSwf);
				_formLoaderInfo.sharedEvents.addEventListener(FormEvents.FORM_DATA_VALID, formDataValidEventHandler, false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(FormEvents.FORM_DATA_INVALID, formDataInvalidEventHandler, false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(FormEvents.FORM_CLEAN, formCleanEventHandler, false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(FormEvents.FORM_DIRTY, formDirtyEventHandler, false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppButtonEvent.HIDE_SAVE_BUTTON, hideSaveHandler, false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppButtonEvent.SHOW_SAVE_BUTTON, showSaveHandler, false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppButtonEvent.HIDE_ALL_ROUTE_BUTTONS, hideCompleteHandler, false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppButtonEvent.SHOW_ALL_ROUTE_BUTTONS, showCompleteHandler, false, 0, true);
				/*
				
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppEvent.FULL_SCREEN, maximizeHandler, false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppEvent.MINIMIZE_SCREEN, minimizeHandler, false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppEvent.CLOSE, closeHandler, false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppButtonEvent.HIDE_ROUTE_BUTTON, hideRouteButtonHandler,
				false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppButtonEvent.SHOW_ROUTE_BUTTON, showRouteButtonHandler,
				false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppButtonEvent.DISABLE_ROUTE_BUTTON, disableRouteButtonHandler,
				false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppButtonEvent.ENABLE_ROUTE_BUTTON, enableRouteButtonHandler,
				false, 0, true);
				
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppEvent.HIDE_ALL_CONTAINER_VIEWS, containerVisibilityHandler,
				false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppEvent.HIDE_TASK_DETAILS_VIEW, containerVisibilityHandler,
				false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppEvent.SHOW_TASK_DETAILS_VIEW, containerVisibilityHandler,
				false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppEvent.HIDE_TASK_FORM_VIEW, containerVisibilityHandler,
				false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppEvent.SHOW_TASK_FORM_VIEW, containerVisibilityHandler,
				false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppEvent.HIDE_ATTACHMENTS_VIEW, containerVisibilityHandler,
				false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppEvent.SHOW_ATTACHMENTS_VIEW, containerVisibilityHandler,
				false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppEvent.HIDE_DIRECTIVES_VIEW, containerVisibilityHandler,
				false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppEvent.SHOW_DIRECTIVES_VIEW, containerVisibilityHandler,
				false, 0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppButtonEvent.RENAME_ROUTE_BUTTON, renameRouteButton, false,
				0, true);
				_formLoaderInfo.sharedEvents.addEventListener(SwfAppButtonEvent.CHANGE_ROUTE_BUTTON_TOOLTIP, changeTooltip,
				false, 0, true);
				
				// the following events need to be trapped for each all of our parent components
				var component:UIComponent = this;
				while (component != parentApplication)
				{
				component.addEventListener(FlexEvent.SHOW, showAndHideHandler, false, 0, true);
				component.addEventListener(FlexEvent.ADD, showAndHideHandler, false, 0, true);
				
				component.addEventListener(FlexEvent.HIDE, showAndHideHandler, false, 0, true);
				component.addEventListener(FlexEvent.REMOVE, showAndHideHandler, false, 0, true);
				
				component = UIComponent(component.parent);
				}*/
			}
			
			//_token.callResultHandlers(null);
		}
		
		protected function showCompleteHandler(event:Event):void
		{
			showRouteButtons = true;
		}
		
		protected function hideCompleteHandler(event:Event):void
		{
			showRouteButtons = false;
			
		}
		
		private function formDataValidEventHandler(event:Event):void
		{
			trace("<-- Workspace: " + FormEvents.FORM_DATA_VALID + " event received from form");
			valid = true;
		}
		
		private function formDataInvalidEventHandler(event:Event):void
		{
			trace("<-- Workspace: " + FormEvents.FORM_DATA_INVALID + " event received from form");
			valid = false;
		}
		
		private function formCleanEventHandler(event:Event):void
		{
			trace("<-- Workspace: " + FormEvents.FORM_CLEAN + " event received from form");
			clean = true;
		}
		
		private function formDirtyEventHandler(event:Event):void
		{
			trace("<-- Workspace: " + FormEvents.FORM_DIRTY + " event received from form");
			clean = false;
		}
		
		private function hideSaveHandler(event:Event):void
		{
			showSaveButton = false;
		}
		
		private function showSaveHandler(event:Event):void
		{
			showSaveButton = true;
		}
	}
}
