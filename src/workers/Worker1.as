package workers
{
	import com.myflashlabs.utils.worker.WorkerBase;
	import flash.utils.ByteArray;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.LoaderInfo;
	import flash.display.Bitmap;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	
	/**
	 * ...
	 * @author MyFlashLab Team - 1/28/2016 11:00 PM
	 */
	public class Worker1 extends WorkerBase
	{
		
		public function Worker1()
		{
		
		}
		
		// these methods must be public because they are called from the main thread.
		public function forLoop($myParam:int):void
		{
			var thisCommand:Function = arguments.callee;
			
			for (var i:int = 0; i < $myParam; i++)
			{
				// call this method to send progress to your delegate
				sendProgress(thisCommand, i);
			}
			
			// call this method as the final message from the worker. When this is called, you cannot send anymore "sendProgress"
			sendResult(thisCommand, $myParam);
		}
		
		public function loadImage(b:ByteArray) {
			var thisCommand:Function = arguments.callee;
			var loader:Loader = new Loader();
			var context:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
			//context.allowLoadBytesCodeExecution = true;
			//context.allowCodeImport = true ;
			//context.allowLoadBytesCodeExecution = true ;
				sendProgress(thisCommand, null,0,0,"HI");
			return
			loader.loadBytes(b,context);

			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function loaderComplete(event){
				

				
				//var l:LoaderInfo = (event.target) as LoaderInfo;	
				
				sendProgress(thisCommand, bitmapData.getPixels(bitmapData.rect),bitmapData.rect.width,bitmapData.rect.height,"HI");
				return
				
				var bitmapData:BitmapData = new BitmapData(100,100,false,0xff0000);//(loader.content as Bitmap).bitmapData;
				
				//bitmapData.draw(l.loader);
				
				//sendProgress(thisCommand, null,100,200);
				var nam:String
				try
				{
					nam = loader.content.toString();
				}
				catch(e)
				{
					nam = e.toString() ;
				}
				//return	
				sendProgress(thisCommand, bitmapData.getPixels(bitmapData.rect),bitmapData.rect.width,bitmapData.rect.height,nam);
				
			});

			//sendResult(thisCommand, 1000);
			
		}
		
	}
}