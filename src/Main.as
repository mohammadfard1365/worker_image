package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.WorkerState;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import workers.Worker1;
	
	// WorkerManager which will be taking care of all complicated stuff about AS Workers for you
	import com.myflashlabs.utils.worker.WorkerManager;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.LoaderInfo;
	import flash.utils.ByteArray;
	import flash.events.MouseEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 1/29/2016 1:17 AM
	 */
	public class Main extends MovieClip
	{
		private var _myWorker:WorkerManager;
		private var _txt:TextField;
		var testbyte:ByteArray;
		
		public function Main()
		{
			_txt = new TextField();
			_txt.autoSize = TextFieldAutoSize.LEFT;
			_txt.defaultTextFormat = new TextFormat(null, 40);
			_txt.x = _txt.y = 250;
			this.addChild(_txt);
			
			//loadX(1);
			
			// init the Manager and pass the class you want to use as your Worker
			_myWorker = new WorkerManager(workers.Worker1, loaderInfo.bytes, this);
			
			// listen to your worker state changes
			_myWorker.addEventListener(Event.WORKER_STATE, onWorkerState);
			
			// fire up the Worker
			_myWorker.start();
			
			this["a"].addEventListener(MouseEvent.CLICK, mouseClicked);		
		}
		private var counter:Number=1;
		function mouseClicked(e:Event){
			
			_myWorker.command("loadFully", onProgress_image_fully, onResult_image, "1");
			return;
			for(var i:uint = 1;i<=24;i++){
				loadX(counter);
			}			
			
			
			
			
				//e.currentTarget.alpha=0.1;			
		}
		private function onProgress_image_fully(p){
			_txt.text=p;
		}
		private function loadX(name) {
			//var imageLoader:Loader = new Loader();
			var request:URLRequest = new URLRequest("pic/" +  name +  ".png");				
			//imageLoader.load(request);
			var rlLoader:URLLoader = new URLLoader();
			rlLoader.dataFormat = URLLoaderDataFormat.BINARY ; 
			rlLoader.addEventListener(Event.COMPLETE,byteLoaded);
			rlLoader.load(request);
			

			function byteLoaded(e):void
			{
				var byteArray:ByteArray = rlLoader.data as ByteArray;
			
				_myWorker.command("loadImage", onProgress_image, onResult_image, byteArray);
				_txt.text = byteArray.length+"";
				
				return
				var loader:Loader = new Loader();
				loader.loadBytes(byteArray);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function s(e){
					_txt.text = "FARD"+"" ;
					addChild(loader.content)
				});
				//this.addChild(loader.contentLoaderInfo.content)
			}
			
			
			/*imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function ff (event) {
				return
				var loaderInfo:LoaderInfo = LoaderInfo(event.target);
				var byteArray:ByteArray = loaderInfo.bytes;
				
				//imageLoader.x=380
				//addChild(imageLoader);
				
				//return
			
				_myWorker.command("loadImage", onProgress_image, onResult_image, byteArray);
				_txt.text = _myWorker.state;

				//trace(byteArray);
				
				
				
			} 
			);	*/	
		}
		private function onProgress_image($progress:*,W:*,H:*,debu:*):void
		{
			if(debu!=null)
			{
				_txt.text = debu ;
				//return;
			}
			try{
				_txt.text = '1 : '+W+','+H;
				
				
				
				/*
				for (var i in ($progress.tt)){
					_txt.appendText(i.toString+":"+$progress.tt[i]);
				}
			*/
				//_txt.text = $progress.toString()+"";
				var bitData:BitmapData = new BitmapData(W,H);
				_txt.text = '2';
				bitData.setPixels(new Rectangle(0,0,W,H),$progress);
				_txt.text = '3';
				var bit:Bitmap = new Bitmap(bitData);
				_txt.text = '4 : '+bit.bitmapData.getPixel(0,0).toString(16);
				bit.x = 380
				bit.alpha=Math.random()*100;
				addChild(bit)

			}catch(e:Error){
				_txt.text =e.message+e.getStackTrace();;
			}
			return
			
			var bmp:Bitmap = new Bitmap($progress.clone());
			
			addChild(bmp);
			_txt.text = "img"+$progress.toString();
		}
		/**
		 * this function can have as many parameters as you wish. 
		 * this is just a contract between the worker class and this delegate.
		 * What you need to notice though, is that it must return void.
		 */
		private function onResult_image($result:Number):void
		{
			return;
			_txt.text = "$result = " + $result;
			
			// terminate the worker when you're done with it.
			_myWorker.terminate();
		}		
		
		private function onWorkerState(e:Event):void
		{
			trace("worker state = " + _myWorker.state)
			
			// if the worker state is 'running', you can start communicating
			if (_myWorker.state == WorkerState.RUNNING)
			{
				// create your own commands in your worker class, Worker1, i.e "forLoop" in this sample and pass in as many parameters as you wish
				//_myWorker.command("forLoop", onProgress, onResult, 10000);
			}
		}
		
		/**
		 * this function can have as many parameters as you wish. 
		 * this is just a contract between the worker class and this delegate.
		 * What you need to notice though, is that it must return void.
		 */
		private function onProgress($progress:Number):void
		{
			_txt.text = "$progress = " + $progress;
		}
		
		/**
		 * this function can have as many parameters as you wish. 
		 * this is just a contract between the worker class and this delegate.
		 * What you need to notice though, is that it must return void.
		 */
		private function onResult($result:Number):void
		{
			_txt.text = "$result = " + $result;
			
			// terminate the worker when you're done with it.
			_myWorker.terminate();
		}
	}
}