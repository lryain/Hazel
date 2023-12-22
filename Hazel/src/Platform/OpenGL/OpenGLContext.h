#pragma once

//#include "GLFW\glfw3.h"
#include "Hazel\Renderer\GraphicsContext.h"

struct GLFWwindow;

namespace Hazel {

	//实现GraphicContext接口
	class OpenGLContext : public GraphicsContext
	{
	public:
		OpenGLContext(GLFWwindow* m_WindowHandle);

		virtual void Init() override;
		virtual void SwapBuffers() override;

	private:
		GLFWwindow* m_WindowHandle;
	};
}


