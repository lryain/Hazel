#pragma once

namespace Hazel {
	// 纯虚函数 等于接口
	class GraphicsContext
	{
	public:
		virtual void Init() = 0;
		virtual void SwapBuffers() = 0;

	private:

	};
}