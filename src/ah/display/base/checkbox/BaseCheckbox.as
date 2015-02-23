/**
 * BaseCheckbox.
 * Date: 20.02.15
 * Time: 16:12
 * Alex Hoch
 */

package ah.display.base.checkbox {
	import ah.display.base.button.BaseButton;
	import ah.display.utils.TextUtils;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class BaseCheckbox extends Sprite {
		//--------------------------------------------------------------------------
		//  Constants
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Variables
		//--------------------------------------------------------------------------
		private var _selected:Boolean;
		private var _isEnable:Boolean = true;

		private var currentWidth:Number = 20;
		private var currentHeight:Number = 20;

		private var labelTF:TextField;
		private var selectedState:BaseButton;
		private var unSelectedState:BaseButton;
		private var statesContainer:Sprite;

		//--------------------------------------------------------------------------
		//  Public properties
		//--------------------------------------------------------------------------
		public function set label(value:String):void {
			labelTF.text = value;
		}

		override public function get width():Number { return currentWidth; }

		override public function set width(value:Number):void {
			currentWidth = value;
			selectedState.width = currentWidth;
			unSelectedState.width = currentWidth;
			labelTF.x = currentWidth + 2;
		}

		override public function get height():Number { return currentHeight; }

		override public function set height(value:Number):void {
			currentHeight = value;
			selectedState.height = currentHeight;
			unSelectedState.height = currentHeight
			labelTF.y = Math.round((currentHeight - labelTF.height) / 2);
		}

		public function get selected():Boolean { return _selected; }

		public function set selected(value:Boolean):void {
			_selected = value;
			if (statesContainer.numChildren) statesContainer.removeChildAt(0);
			var currentState:BaseButton = _selected ? selectedState : unSelectedState;
			currentState.isEnable = _isEnable;
			statesContainer.addChild(currentState);
		}

		public function get isEnable():Boolean { return _isEnable; }

		public function set isEnable(value:Boolean):void {
			_isEnable = value;
			if (statesContainer.numChildren) (statesContainer.getChildAt(0) as BaseButton).isEnable = _isEnable;
		}

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
		public function BaseCheckbox(label:String = '', selected:Boolean = false, isEnable:Boolean = true) {
			draw();
			startListen();

			this.label = label;

			this.selected = selected;
			this.isEnable = isEnable;
		}

		//--------------------------------------------------------------------------
		//  Public methods
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Protected methods
		//--------------------------------------------------------------------------
		protected function drawSelectedState():BaseButton {
			throw new Error('This function must be overrided');
		}

		protected function drawUnSelectedState():BaseButton {
			throw new Error('This function must be overrided');
		}

		//--------------------------------------------------------------------------
		//  Private methods
		//--------------------------------------------------------------------------
		private function draw():void {
			drawStates();
			drawTitle();
		}

		private function drawStates():void {
			statesContainer = new Sprite();
			this.addChild(statesContainer);

			selectedState = drawSelectedState();
			unSelectedState = drawUnSelectedState();
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
			labelTF.x = currentWidth + 2;
			labelTF.y = Math.round((currentHeight - labelTF.height) / 2);
			this.addChild(labelTF);
		}

		private function startListen():void {
			statesContainer.addEventListener(MouseEvent.CLICK, mouseHandler);
		}

		//--------------------------------------------------------------------------
		//  Handlers 
		//--------------------------------------------------------------------------
		private function mouseHandler(event:MouseEvent):void {
			if (isEnable) selected = !selected;
		}
	}
}
