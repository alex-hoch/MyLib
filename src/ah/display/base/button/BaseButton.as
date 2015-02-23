/**
 * BaseButton.
 * Date: 20.02.15
 * Time: 11:22
 * Alex Hoch
 */

package ah.display.base.button {
	import ah.display.utils.TextUtils;
	import ah.interfaces.IDestroyable;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class BaseButton extends Sprite implements IDestroyable {
		//--------------------------------------------------------------------------
		//  Constants
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Variables
		//--------------------------------------------------------------------------
		private var _isEnable:Boolean = true;
		private var _deactivateOnDisableState:Boolean = true;
		private var _destroyed:Boolean;

		private var currentWidth:Number = 100;
		private var currentHeight:Number = 22;

		private var labelTF:TextField;
		private var statesContainer:Sprite;
		private var outState:DisplayObject;
		private var overState:DisplayObject;
		private var downState:DisplayObject;
		private var disableState:DisplayObject;

		//--------------------------------------------------------------------------
		//  Public properties
		//--------------------------------------------------------------------------
		public function set label(value:String):void {
			labelTF.text = value;
			positioning();
		}

		public function get isEnable():Boolean { return _isEnable; }

		public function set isEnable(value:Boolean):void {
			_isEnable = value;
			this.buttonMode = _isEnable || !_deactivateOnDisableState;
			setActiveState(isEnable ? outState : disableState)
		}

		override public function get width():Number { return currentWidth; }

		override public function set width(value:Number):void {
			currentWidth = value;
			redraw();
		}

		override public function get height():Number { return currentHeight; }

		override public function set height(value:Number):void {
			currentHeight = value;
			redraw();
		}

		public function set deactivateOnDisableState(value:Boolean):void {
			_deactivateOnDisableState = value;
			this.buttonMode = _isEnable || !_deactivateOnDisableState;
		}

		public function get destroyed():Boolean { return _destroyed; }

		//--------------------------------------------------------------------------
		//  Protected properties
		//--------------------------------------------------------------------------
		protected function get titleFontSize():int {return 12;}

		protected function get titleColor():uint { return 0x000000; }

		//--------------------------------------------------------------------------
		//  Private properties
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Constructor
		//--------------------------------------------------------------------------
		public function BaseButton(label:String = '', isEnable:Boolean = true) {
			draw();
			startListen();
			this.label = label;

			this.isEnable = isEnable;
		}

		//--------------------------------------------------------------------------
		//  Public methods
		//--------------------------------------------------------------------------
		public function destroy():void {
			if (destroyed) return;
			stopListen();
		}

		//--------------------------------------------------------------------------
		//  Protected methods
		//--------------------------------------------------------------------------
		protected function drawOutState():DisplayObject {
			throw new Error('This function must be overrided');
		}

		protected function drawOverState():DisplayObject {
			throw new Error('This function must be overrided');
		}

		protected function drawDownState():DisplayObject {
			throw new Error('This function must be overrided');
		}

		protected function drawDisableState():DisplayObject {
			throw new Error('This function must be overrided');
		}

		//--------------------------------------------------------------------------
		//  Private methods
		//--------------------------------------------------------------------------
		private function draw():void {
			statesContainer = new Sprite();
			statesContainer.mouseChildren = false;
			this.addChild(statesContainer);

			drawStates();
			drawTitle();
		}

		private function drawStates():void {
			outState = drawOutState();
			overState = drawOverState();
			downState = drawDownState();
			disableState = drawDisableState();
		}

		private function drawTitle():void {
			labelTF = TextUtils.getNewTextField({
				size:         titleFontSize,
				color:        titleColor,
				selectable:   false,
				bold:         true,
				mouseEnabled: false,
				autoSize:     TextFieldAutoSize.LEFT
			});
			this.addChild(labelTF);
		}

		private function startListen():void {
			statesContainer.addEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
			statesContainer.addEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
			statesContainer.addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			statesContainer.addEventListener(MouseEvent.CLICK, mouseHandler);
		}

		private function stopListen():void {
			statesContainer.removeEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
			statesContainer.removeEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
			statesContainer.removeEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			statesContainer.removeEventListener(MouseEvent.CLICK, mouseHandler);
		}

		private function positioning():void {
			labelTF.x = Math.round((currentWidth - labelTF.width) / 2);
			labelTF.y = Math.round((currentHeight - labelTF.height) / 2) - 1;
		}

		private function destroyStates():void {
			while (statesContainer.numChildren) {
				statesContainer.removeChildAt(0);
			}
		}

		private function setActiveState(state:DisplayObject):void {
			while (statesContainer.numChildren) {
				statesContainer.removeChildAt(0);
			}
			statesContainer.addChild(state);
		}

		private function redraw():void {
			destroyStates();
			drawStates();
			setActiveState(isEnable ? outState : disableState)
			positioning();
		}

		//--------------------------------------------------------------------------
		//  Handlers 
		//--------------------------------------------------------------------------
		private function mouseHandler(event:MouseEvent):void {
			if (!isEnable) {
				if (_deactivateOnDisableState) {
					event.stopImmediatePropagation();
				}
				return;
			}
			switch (event.type) {
				case MouseEvent.MOUSE_UP:
					stage.removeEventListener(MouseEvent.MOUSE_UP, mouseHandler);
					if (statesContainer.getChildAt(0) == downState) {
						setActiveState(overState);
					} else {
						setActiveState(outState);
					}
					break;
				case MouseEvent.MOUSE_OVER:
					setActiveState(overState);
					break;
				case MouseEvent.MOUSE_OUT:
					setActiveState(outState);
					break;
				case MouseEvent.MOUSE_DOWN:
					setActiveState(downState);
					stage.addEventListener(MouseEvent.MOUSE_UP, mouseHandler, false, 0, true);
					break;
			}
		}
	}
}