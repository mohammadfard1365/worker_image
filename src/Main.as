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
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 1/29/2016 1:17 AM
	 */
	public class Main extends Sprite
	{
		private var _myWorker:WorkerManager;
		private var _txt:TextField;
		var testbyte:ByteArray;
		
		public function Main()
		{
			_txt = new TextField();
			_txt.autoSize = TextFieldAutoSize.LEFT;
			_txt.defaultTextFormat = new TextFormat(null, 40);
			_txt.x = _txt.y = 50;
			this.addChild(_txt);
			
			loadX();
			
			// init the Manager and pass the class you want to use as your Worker
			_myWorker = new WorkerManager(workers.Worker1, loaderInfo.bytes, this);
			
			// listen to your worker state changes
			_myWorker.addEventListener(Event.WORKER_STATE, onWorkerState);
			
			// fire up the Worker
			_myWorker.start();
			
			this["a"].addEventListener(MouseEvent.CLICK, mouseClicked);		
		}
		function mouseClicked(e:Event){
			
				_myWorker.command("loadImage", onProgress_image, onResult_image, testbyte);
				_txt.text = _myWorker.state;
				e.currentTarget.alpha=0.1			
		}
		private function onProgress_image($progress:*,W:*,H:*):void
		{

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
		private function loadX() {
			var imageLoader:Loader = new Loader();
			var request:URLRequest = new URLRequest("a.jpg");				
			imageLoader.load(request);

			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function ff (event) {
				
				var loaderInfo:LoaderInfo = LoaderInfo(event.target);
				var byteArray:ByteArray = loaderInfo.bytes;
				testbyte = byteArray;
				
				//trace(byteArray);
				
				
				
			} 
			);		
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