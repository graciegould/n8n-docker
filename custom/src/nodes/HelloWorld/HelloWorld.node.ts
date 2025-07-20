import {
	IExecuteFunctions,
	INodeExecutionData,
	INodeType,
	INodeTypeDescription,
	NodeConnectionType,
} from 'n8n-workflow';

export class HelloWorld implements INodeType {
	description: INodeTypeDescription = {
		displayName: 'Hello World',
		name: 'helloWorld',
		icon: 'file:helloWorld.svg',
		group: ['transform'],
		version: 1,
		description: 'A simple Hello World node',
		defaults: {
			name: 'Hello World',
		},
		inputs: [NodeConnectionType.Main],
		outputs: [NodeConnectionType.Main],
		properties: [
			{
				displayName: 'Name',
				name: 'name',
				type: 'string',
				default: 'World',
				placeholder: 'Enter a name',
				description: 'The name to greet',
			},
			{
				displayName: 'Message',
				name: 'message',
				type: 'string',
				default: 'Hello',
				placeholder: 'Enter a greeting message',
				description: 'The greeting message',
			},
		],
	};

	async execute(this: IExecuteFunctions): Promise<INodeExecutionData[][]> {
		const items = this.getInputData();
		const returnData: INodeExecutionData[] = [];

		for (let i = 0; i < items.length; i++) {
			const name = this.getNodeParameter('name', i, 'World') as string;
			const message = this.getNodeParameter('message', i, 'Hello') as string;

			const greeting = `${message}, ${name}!`;
			const timestamp = new Date().toISOString();

			const newItem: INodeExecutionData = {
				json: {
					greeting,
					timestamp,
					name,
					message,
				},
			};

			returnData.push(newItem);
		}

		return [returnData];
	}
} 