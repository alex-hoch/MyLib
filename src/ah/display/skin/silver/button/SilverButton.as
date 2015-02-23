/**
 * SilverButton.
 * Date: 20.02.15
 * Time: 11:47
 * Alex Hoch
 */

package ah.display.skin.silver.button {
	import ah.display.base.button.BaseButton;

	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;

	public class SilverButton extends BaseButton {
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

		//--------------------------------------------------------------------------
		//  Private properties
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Constructor
		//--------------------------------------------------------------------------
		public function SilverButton(title:String = '', isEnable:Boolean = true) {
			super(title, isEnable);
		}

		//--------------------------------------------------------------------------
		//  Public methods
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Protected methods
		//--------------------------------------------------------------------------
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

		override protected function get titleColor():uint { return 0x555555; }

		//--------------------------------------------------------------------------
		//  Private methods
		//--------------------------------------------------------------------------
		private function drawState(colors:Array, alphas:Array):DisplayObject {
			var state:Sprite = new Sprite();
			var mtrx:Matrix = new Matrix();
			mtrx.createGradientBox(this.width * 0.6, this.height * 0.6, 0.5 * Math.PI);
			state.graphics.lineStyle(2, 0x888888, 0.5);
			state.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, [0x00, 0xFF], mtrx, SpreadMethod.PAD);
			state.graphics.drawRoundRect(0, 0, this.width, this.height, 10, 10);
			state.graphics.endFill();
			return state;
		}

		//--------------------------------------------------------------------------
		//  Handlers 
		//--------------------------------------------------------------------------
	}
}
