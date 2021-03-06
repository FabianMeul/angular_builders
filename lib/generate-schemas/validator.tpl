import * as AJV from 'ajv';
import { <%= type %> } from '<%= typePath %>';
import { ValidatorSchema, ValidatorSchemaConstruct, ValidatorSchemaResult } from '@tom-odb/angular-builders';

export class <%= type %>Schema implements ValidatorSchemaConstruct {
  public schema: ValidatorSchema =<%= schema %>;

  private ajv: any;
  private data: <%= type %>;

	constructor(data: any) {
	this.data = data;
		this.ajv = new AJV({
			allErrors: true,
			coerceTypes: true,
			nullable: true,
			ownProperties: true,
			removeAdditional: 'failing',
			useDefaults: true,
		});
	}

	public validate(data: any): ValidatorSchemaResult<<%= type %>> {
		const validated = this.ajv.validate(this.schema, data);

		if (!validated) {
			return {
				errors: this.ajv.errors,
				result: null,
			};
		}

		return {
			errors: [],
			result: validated,
		};
  }

  public toJSON(): <%= type %> {
    if (!this.data || this.validate(this.data).errors.length > 0) {
      return null;
    }

    return <%= jsonData %>;
  }
}
