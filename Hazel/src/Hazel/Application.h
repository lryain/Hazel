#pragma once

#include "Core.h"

#include "Window.h"
#include "Hazel\Core\LayerStack.h"
#include "Events\Event.h"
#include "Hazel\Events\ApplicationEvent.h"
#include "Window.h"

namespace Hazel {
	//class __declspec(dllexport) Application
	class HAZEL_API Application
	{
	public:
		Application();
		virtual ~Application();

		void Run();

		void OnEvent(Event& e);

		void PushLayer(Layer* layer);
		void PushOverlay(Layer* layer);

	private:
		bool OnWindowClose(WindowCloseEvent& e);
		Window* m_Window;
		bool m_Running = true;

		// 层
		LayerStack m_LayerStack;
	};

	// To be defined in CLIENT
	Application* CreateApplication();
}