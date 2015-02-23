/**
 * SilverCheckbox.
 * Date: 23.02.15
 * Time: 17:03
 * Alex Hoch
 */

package ah.display.skin.silver.checkbox {
	import ah.display.base.button.BaseButton;
	import ah.display.base.checkbox.BaseCheckbox;

	public class SilverCheckbox extends BaseCheckbox {
		//--------------------------------------------------------------------------
		//  Constants
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Variables
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Public properties
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Protected properties
		//--------------------------------------------------------------------------
		override protected function get titleColor():uint { return 0x555555; }

		//--------------------------------------------------------------------------
		//  Private properties
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Constructor
		//--------------------------------------------------------------------------
		public function SilverCheckbox(label:String = '', selected:Boolean = false, isEnable:Boolean = true) {
			super(label, selected, isEnable);
			width = 20;
			height = 20;
		}

		//--------------------------------------------------------------------------
		//  Public methods
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Protected methods
		//--------------------------------------------------------------------------
		override protected function drawSelectedState():BaseButton {
			return new SilverCheckboxState(true);
		}

		override protected function drawUnSelectedState():BaseButton {
			return new SilverCheckboxState(false);
		}

		//--------------------------------------------------------------------------
		//  Private methods
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Handlers 
		//--------------------------------------------------------------------------
	}
}

import ah.display.base.button.BaseButton;

import flash.display.DisplayObject;
import flash.display.GradientType;
import flash.display.SpreadMethod;
import flash.display.Sprite;
import flash.geom.Matrix;

class SilverCheckboxState extends BaseButton {
	private var withThumb:Boolean;

	public function SilverCheckboxState(withThumb:Boolean) {
		this.withThumb = withThumb;
		super();
	}

	override protected function drawOutState():DisplayObject {
		return drawState([0xE7E7E7, 0xD8D8D8], [1, 1]);
	}

	override protected function drawOverState():DisplayObject {
		return drawState([0xF3F3F3, 0xE9E9E9], [1, 1]);
	}

	override protected function drawDownState():DisplayObject {
		return drawState([0xDCDCDC, 0xC8C8C8], [1, 1]);
	}

	override protected function drawDisableState():DisplayObject {
		return drawState([0x777777, 0x333333], [0.38, 0.38]);
	}

	private function drawState(colors:Array, alphas:Array):Sprite {
		var result:Sprite = new Sprite();
		var mtrx:Matrix = new Matrix();
		mtrx.createGradientBox(this.width * 0.6, this.height * 0.6, 0.5 * Math.PI);
		result.graphics.lineStyle(2, 0x888888, 0.5);
		result.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, [0x00, 0xFF], mtrx, SpreadMethod.PAD);
		result.graphics.drawRoundRect(0, 0, this.width, this.height, 10, 10);
		result.graphics.endFill();

		if (withThumb) {
			var thumb:Sprite = new Sprite();
			thumb.mouseEnabled = false;
			thumb.graphics.lineStyle(3, 0x777777);
			thumb.graphics.moveTo(width * 0.2, height * 0.45);
			thumb.graphics.lineTo(width * 0.45, height * 0.8);
			thumb.graphics.lineTo(width * 0.8, height * 0.2);
			result.addChild(thumb);
		}
		return result;
	}
}