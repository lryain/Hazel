#include "hzpch.h"
#include "Application.h"
#include "Events\ApplicationEvent.h"
#include "Hazel\Log.h"
#include "GLFW\glfw3.h"

namespace Hazel {

	// 定义一个宏来简化事件绑定函数
	#define BIND_EVENT_FN(x) std::bind(&Application::x, this, std::placeholders::_1)

	Application::Application() {
		m_Window = Window::Create();
		m_Window->SetEventCallback(BIND_EVENT_FN(OnEvent));
	}
	
	Application::~Application() {

	}

	void Application::OnEvent(Event& e)
	{
		EventDispatcher dispatcher(e);
		// 绑定窗口关闭回调 处理函数
		dispatcher.Dispatch<WindowCloseEvent>(BIND_EVENT_FN(OnWindowClose));

		HZ_CORE_INFO("{0}", e);
	}

	// 窗口关闭回调 处理函数
	bool Application::OnWindowClose(WindowCloseEvent& e) {
		m_Running = false;
		return true;
	}

	void Application::Run() {
		
		while (m_Running)
		{
			glClearColor(1, 0, 1, 1);
			glClear(GL_COLOR_BUFFER_BIT);
			m_Window->OnUpdate();
		}
	}
}