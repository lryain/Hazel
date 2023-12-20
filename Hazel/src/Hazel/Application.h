#pragma once

#include "Core.h"

#include "Window.h"
#include "Hazel\Core\LayerStack.h"
#include "Events\Event.h"
#include "Hazel\Events\ApplicationEvent.h"

#include "Hazel\ImGui\ImGuiLayer.h"

namespace Hazel {
	//class __declspec(dllexport) Application

	//struct ApplicationSpecification
	//{
	//	std::string Name = "Hazel Application";
	//	std::string WorkingDirectory;
	//	ApplicationCommandLineArgs CommandLineArgs;

	//};

	class HAZEL_API Application
	{
	public:
		Application();

		virtual ~Application();

		void Run();

		void OnEvent(Event& e);

		void PushLayer(Layer* layer);
		void PushOverlay(Layer* layer);

		static Application& Get() { return *s_Instance; }

		Window& GetWindow() { return *m_Window; }

	private:
		bool OnWindowClose(WindowCloseEvent& e);
		std::unique_ptr<Window> m_Window;
		//std::unique_ptr<ImGuiLayer> m_ImGuiLayer;
		ImGuiLayer* m_ImGuiLayer;
		bool m_Running = true;

		// 层
		LayerStack m_LayerStack;

	private:
		static Application* s_Instance;
	};

	// To be defined in CLIENT
	Application* CreateApplication();
}